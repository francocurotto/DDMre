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
var rollzone_tab_selected = false ## true when rollzone tab is selected
var dragging = false ## true when player is dragging for roll
var rolling = false ## true when dice are rolling
var roll_velocity = Vector2.ZERO ## Initial velocity of roll
var triplet_size : int = 0 :
	get():
		return %Triplet.get_child_count()
#endregion

#region builtin functions
func _physics_process(_delta: float) -> void:
	if all_dice_stopped():
		$Label.text = "[color=red]STOPPED[/color]" 
	else:
		$Label.text = "[color=green]MOVING[/color]"
	
func _input(event):
	if input_in_rollzone(event):
		if player_gui.guistate == Globals.GUISTATE.ROLL:
			if triplet_size >= 3 and not rolling:
				input_roll(event)
		elif player_gui.guistate == Globals.GUISTATE.DIMENSION:
			input_dim_select(event)
	else:
		dragging = false
#endregion

#region public functions
func add_dice(dice):
	var copy = dice.clone()
	%Triplet.add_child(copy)
	copy.position = INITPOS[triplet_size-1]
	copy.roll_stopped.connect(on_dice_stopped)
	copy.dim_setup_finished.connect(on_dim_setup_finished)

func remove_dice(selected_dice_list):
	for dice in get_triplet():
		dice.queue_free()
		%Triplet.remove_child(dice)
	for dice in selected_dice_list:
		add_dice(dice)
#endregion

#region signals callbacks
func on_dice_stopped():
	if all_dice_stopped():
		rolling = false
		if not any_dice_cocked():
			resolve_roll()

func on_dim_setup_finished():
	player_gui.guistate = Globals.GUISTATE.DIMENSION
#endregion

#region private functions
func get_triplet():
	return %Triplet.get_children()

func input_in_rollzone(event):
	var in_rect = get_global_rect().has_point(event.position)
	return in_rect and rollzone_tab_selected

func input_roll(event):
	if event is InputEventScreenTouch and event.pressed:
		dragging = true
	# if drag, register velocity
	elif event is InputEventScreenDrag and dragging:
		roll_velocity = event.velocity
	# if drag released, roll dice
	elif event is InputEventScreenTouch and not event.pressed and dragging:
		roll_dice(roll_velocity)
		dragging = false

func roll_dice(velocity):
	rolling = true
	roll_started.emit()
	for dice in get_triplet():
		dice.roll(velocity)

func input_dim_select(event):
	if event is InputEventScreenTouch and event.pressed:
		var touch_pos = %SubViewport.get_mouse_position()
		var object = Globals.get_node3d_on_touch(touch_pos, %Camera3D)
		if object in get_triplet():
			select_dimdice(object)

func select_dimdice(dimdice):
	for dice in get_triplet():
		dice.fade = false
	Globals.dungeon.update_dimdice(dimdice.clone(), player_gui.net)
	dimdice.fade = true
	dimdice_selected.emit(dimdice)

func all_dice_stopped():
	return get_triplet().all(func(dice): return not dice.moving)

func any_dice_cocked():
	return get_triplet().any(func(dice): return dice.rolled_side == null)

func resolve_roll():
	var summon_dice = []
	# resolve crest rolls
	for dice in get_triplet():
		var side = dice.rolled_side
		if side.crest != "SUMMON":
			crest_side_rolled.emit(side)
		else:
			summon_dice.append(dice)
	# resolve summon rolls
	var dim_dice = []
	for level in range(1,4):
		for dice in summon_dice:
			if dice.rolled_side.mult == level:
				dim_dice.append(dice)
		if len(dim_dice) >= 2:
			break
		dim_dice = []
	# remove dice not used for dimension
	for dice in get_triplet():
		if dice not in dim_dice:
			dice.remove()
	# if can dimension, setup dimension interface
	if not dim_dice.is_empty():
		setup_dim(dim_dice)

func setup_dim(dimdice_list):
	# move dice
	var n_dice = len(dimdice_list)
	for i in len(dimdice_list):
		dimdice_list[i].setup_dim_select(DIMPOS[n_dice][i])
#endregion
