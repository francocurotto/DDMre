extends PanelContainer

#region signals
signal roll_started
signal crest_side_rolled
signal dimdice_selected
#endregion

#region constants
const INITPOS = [Vector3(-2.5,0,0), Vector3(0,0,0), Vector3(2.5,0,0)]
const DIMPOS = {
	2: [Vector3(-1.5,0,0), Vector3(1.5,0,0)],
	3: [Vector3(-2.5,0,0), Vector3(0,0,0), Vector3(2.5,0,0)]
}
#endregion

#region export variables
@export var debug_roll : bool = true
#endregion

#region public variables
var player_gui
#endregion

#region private variables
var rollable : bool = true
var triplet_size : int = 0 :
	get():
		return %Triplet.get_child_count()
#endregion

#region onready variables
@onready var controls = $TouchControls
#endregion

#region builtin functions
func _ready() -> void:
	player_gui = find_parent("PlayerGUI?")
	controls.set_raycast(%SubViewport, %Camera3D)
	controls.touch_pressed.connect(on_touch_pressed)
	controls.drag_released.connect(on_drag_released)

func _process(_delta: float) -> void:
	if debug_roll:
		var text = "rollable: " + str(rollable) +"\n"
		text += "moving: " + ", ".join(get_triplet().map(func(d):return d.moving)) + "\n"
		text += "roll_flag: "+ ", ".join(get_triplet().map(func(d):return d.roll_flag)) + "\n"
		text += "translating: "+ ", ".join(get_triplet().map(func(d):return d.translating)) + "\n"
		text += "rotating: "+ ", ".join(get_triplet().map(func(d):return d.rotating)) + "\n"
		text += "lvelocity: " + ", ".join(get_triplet().map(func(d):return "%.2f" % d.linear_velocity.length())) + "\n"
		text += "avelocity: " + ", ".join(get_triplet().map(func(d):return "%.2f" % d.angular_velocity.length()))
		$DebugLabel.text = text
#endregion

#region public functions
func add_dice(dice):
	var copy = dice.clone()
	%Triplet.add_child(copy)
	copy.position = INITPOS[triplet_size-1]
	copy.dice_stopped.connect(on_dice_stopped)
	copy.dim_setup_finished.connect(on_dim_setup_finished)
	rollable = triplet_size == 3

func remove_dice(selected_dice_list):
	for dice in get_triplet():
		dice.queue_free()
		%Triplet.remove_child(dice)
	for dice in selected_dice_list:
		add_dice(dice)
	rollable = false
#endregion

#region signals callbacks
func on_drag_released():
	if rollable:
		roll_dice(controls.velocity)

func on_touch_pressed():
	if player_gui.state == Globals.GUI_STATE.DIMENSION:
		var touched_object = controls.touched_object
		if touched_object in get_triplet():
			select_dimdice(touched_object)

func on_dice_stopped():
	if not any_dice_rolling():
		if any_dice_cocked():
			rollable = true
		else:
			resolve_roll()

func on_dim_setup_finished():
	player_gui.state = Globals.GUI_STATE.DIMENSION

func on_dimension_started():
	controls.disabled = true
	%SkipButton.visible = false
	remove_triplet()

func _on_skip_button_pressed() -> void:
	on_dimension_started() # same effect as skip button pressed
	player_gui.state = Globals.GUI_STATE.DUNGEON
#endregion

#region private functions
func get_triplet():
	return %Triplet.get_children()

func remove_triplet():
	for dice in %Triplet.get_children():
		dice.queue_free()

func roll_dice(velocity):
	rollable = false
	roll_started.emit()
	for dice in get_triplet():
		dice.roll(velocity)

func select_dimdice(dimdice):
	dimdice_selected.emit(dimdice)
	for dice in get_triplet():
		dice.highlight = false
	dimdice.highlight = true
	dimdice_selected.emit(dimdice)

func any_dice_rolling():
	return get_triplet().any(func(dice): return dice.roll_flag)

func any_dice_cocked():
	return get_triplet().any(func(dice): return dice.rolled_side == null)

func resolve_roll():
	var summon_dice = resolve_crest_sides()
	var dim_dice = resolve_summon_sides(summon_dice)
	var tween = create_tween().set_parallel()
	remove_not_dim_dice(tween, dim_dice)
	if not dim_dice.is_empty():
		setup_dim(tween, dim_dice)
	else:
		await tween.finished
		player_gui.state = Globals.GUI_STATE.DUNGEON

func resolve_crest_sides():
	var summon_dice = []
	# resolve crest rolls
	for dice in get_triplet():
		var side = dice.rolled_side
		if side.crest != "SUMMON":
			crest_side_rolled.emit(side)
		else:
			summon_dice.append(dice)
	return summon_dice

func resolve_summon_sides(summon_dice):
	var dim_dice = []
	for level in range(1,5):
		for dice in summon_dice:
			if dice.rolled_side.mult == level:
				dim_dice.append(dice)
		if len(dim_dice) >= 2:
			return dim_dice
		dim_dice = []
	return dim_dice

func remove_not_dim_dice(tween, dim_dice):
	for dice in get_triplet():
		if dice not in dim_dice:
			dice.tween_remove(tween)

func setup_dim(tween, dimdice_list):
	# move dice
	var dimdice_positions = DIMPOS[len(dimdice_list)]
	for i in len(dimdice_list):
		dimdice_list[i].setup_dim_select(tween, dimdice_positions[i])
	await tween.finished
	%SkipButton.visible = true
#endregion
