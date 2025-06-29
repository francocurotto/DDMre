extends PanelContainer

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
#endregion

#region builtin functions
func _input(event):
	if input_in_rollzone(event):
		if player_gui.guistate == Globals.GUISTATE.ROLL:
			if %DiceList.get_child_count() >= 3 and not rolling:
				input_roll(event)
		elif player_gui.guistate == Globals.GUISTATE.DIMENSION:
			input_dim_select(event)
	else:
		dragging = false
#endregion

#region public functions
func update_dice(dice_buttons):
	# remove previous dice
	for dice in %DiceList.get_children():
		dice.queue_free()
		%DiceList.remove_child(dice)
	# add new dice
	for i in len(dice_buttons):
		var dice = dice_buttons[i].dice.duplicate()
		%DiceList.add_child(dice)
		dice.position = INITPOS[i]
		dice.state = dice.STATE.PREROLL
		dice.roll_stopped.connect(on_dice_stopped)
		dice.dim_setup_finished.connect(
			func(): player_gui.guistate = Globals.GUISTATE.DIMENSION)
#endregion

#region signals callbacks
func on_dice_stopped():
	if all_dice_stopped():
		rolling = false
		if not any_dice_cocked():
			resolve_roll()
#endregion

#region private functions
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

func input_dim_select(event):
	if event is InputEventScreenTouch and event.pressed:
		var touch_pos = %SubViewport.get_mouse_position()
		var object = Globals.get_node3d_on_touch(touch_pos, %Camera3D)
		if object in %DiceList.get_children():
			select_dimdice(object)

func select_dimdice(dimdice):
	for dice in %DiceList.get_children():
		dice.fade = false
	Events.dimdice_selected.emit(dimdice.duplicate(), player_gui.net)
	dimdice.fade = true

func roll_dice(velocity):
	rolling = true
	Events.roll_started.emit()
	for dice in %DiceList.get_children():
		dice.roll(velocity)

func all_dice_stopped():
	return %DiceList.get_children().all(func(dice): return not dice.moving)

func any_dice_cocked():
	return %DiceList.get_children().any(func(dice): return dice.rolled_side == null)

func resolve_roll():
	var summon_dice = []
	# resolve crest rolls
	for dice in %DiceList.get_children():
		var side = dice.rolled_side
		if side.crest != "SUMMON":
			Events.crest_side_rolled.emit(side)
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
	for dice in %DiceList.get_children():
		if dice not in dim_dice:
			dice.remove()
	# if can dimension, setup dimension interface
	if not dim_dice.is_empty():
		setup_dim(dim_dice)

func setup_dim(dim_dice):
	# move dice
	var ndice = len(dim_dice)
	for i in len(dim_dice):
		dim_dice[i].setup_dim_select(DIMPOS[ndice][i])
#endregion
