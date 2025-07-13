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

#region public variables
var player_gui
#endregion

#region private variables
var rolling = false ## true when dice are rolling
var triplet_size : int = 0 :
	get():
		return %Triplet.get_child_count()
#endregion

#region onready variables
@onready var controls = $TouchControls
#endregion

#region builtin functions
func _ready() -> void:
	controls.set_raycast(%SubViewport)
	controls.touch_pressed.connect(on_touch_pressed)
	controls.drag_released.connect(on_drag_released)
#endregion

#region public functions
func add_dice(dice):
	var copy = dice.clone()
	%Triplet.add_child(copy)
	copy.position = INITPOS[triplet_size-1]
	copy.dice_stopped.connect(on_dice_stopped)
	copy.dim_setup_finished.connect(on_dim_setup_finished)

func remove_dice(selected_dice_list):
	for dice in get_triplet():
		dice.queue_free()
		%Triplet.remove_child(dice)
	for dice in selected_dice_list:
		add_dice(dice)
#endregion

#region signals callbacks
func on_drag_released():
	if player_gui.guistate == Globals.GUISTATE.ROLL:
		if triplet_size >= 3 and not rolling:
			roll_dice(controls.velocity)

func on_touch_pressed():
	if player_gui.guistate == Globals.GUISTATE.DIMENSION:
		var touched_object = controls.get_touched_object()
		if touched_object in get_triplet():
			select_dimdice(touched_object)

func on_dice_stopped():
	if all_dice_stopped():
		if any_dice_cocked():
			rolling = false
		else:
			resolve_roll()

func on_dim_setup_finished():
	player_gui.guistate = Globals.GUISTATE.DIMENSION
#endregion

#region private functions
func get_triplet():
	return %Triplet.get_children()

func set_triplet_rollable(rollable):
	for dice in get_triplet():
		dice.rollable = rollable

func roll_dice(velocity):
	rolling = true
	set_triplet_rollable(true)
	roll_started.emit()
	for dice in get_triplet():
		dice.roll(velocity)

func select_dimdice(dimdice):
	dimdice_selected.emit(dimdice)
	for dice in get_triplet():
		dice.highlight = false
	dimdice.highlight = true
	dimdice_selected.emit(dimdice)

func all_dice_stopped():
	return get_triplet().all(func(dice): return not dice.moving)

func any_dice_cocked():
	return get_triplet().any(func(dice): return dice.rolled_side == null)

func resolve_roll():
	set_triplet_rollable(false)
	var summon_dice = resolve_crest_sides()
	var dim_dice = resolve_summon_sides(summon_dice)
	remove_not_dim_dice(dim_dice)
	if not dim_dice.is_empty():
		setup_dim(dim_dice)

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
	for level in range(1,4):
		for dice in summon_dice:
			if dice.rolled_side.mult == level:
				dim_dice.append(dice)
		if len(dim_dice) >= 2:
			return dim_dice
		dim_dice = []
	return dim_dice

func remove_not_dim_dice(dim_dice):
	for dice in get_triplet():
		if dice not in dim_dice:
			dice.remove()

func setup_dim(dimdice_list):
	# move dice
	var n_dice = len(dimdice_list)
	for i in len(dimdice_list):
		dimdice_list[i].setup_dim_select(DIMPOS[n_dice][i])
#endregion
