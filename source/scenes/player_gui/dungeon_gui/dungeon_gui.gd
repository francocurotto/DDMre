extends Control

#region enums
enum GUI_SUBSTATE {INIT, MOVE, MOVE2, ATTACK, ATTACK2}
#endregion

#region signals
signal deactivate_summon_info
signal summon_touched
signal dungeon_cancel_button_pressed
signal monster_moved
#endregion

#region constants
const DIMDICE_Y_POSITION = 2
const DIMDICE_DRAG_THRESHOLD = 10
const DIMDICE_INIT_ROTATION = {1: Vector3(0,0,0), 2: Vector3(0, PI, 0)}
#endregion

#region public variables
var player_gui
#endregion

#region private variables
var dimdice_dragging = false
var dimdice_position : Vector3
var dimcoor : Vector2i
var selected_monster = null
var move_path = null
var gui_substate = GUI_SUBSTATE.INIT
#endregion

#region onready variables
@onready var controls = $TouchControls
@onready var camera_reset = %CameraReset
@onready var dungeon_buttons = %DungeonButtons
#endregion

#region builtin functions
func _ready() -> void:
	player_gui = find_parent("PlayerGUI?")
	controls.mask = Globals.LAYERS.DICE + \
		Globals.LAYERS.BASE_TILES + \
		Globals.LAYERS.PATH_TILES + \
		Globals.LAYERS.SUMMONS
	controls.touch_released.connect(on_touch_released)
	controls.dragging.connect(on_dragging)
	controls.drag_released.connect(on_drag_released)
	controls.pinching.connect(on_pinching)
	dungeon_buttons.cancel_button_pressed.connect(on_cancel_button_pressed)
	dungeon_buttons.move_action_started.connect(on_move_action_started)
	dungeon_buttons.move_path_confirmed.connect(on_move_path_confirmed)
	dungeon_buttons.attack_action_started.connect(on_attack_action_started)
#endregion

#region public functions
func enable():
	controls.disabled = false

func disable():
	controls.disabled = true

func set_raycast(viewport, camera3d):
	controls.set_raycast(viewport, camera3d)
#endregion

#region signals callbacks
func on_dimdice_selected(original_dimdice):
	var dimdice = original_dimdice.clone()
	dimdice.highlight = false
	dimdice.position = dimdice_position
	dimdice.rotation = DIMDICE_INIT_ROTATION[player_gui.player]
	dimdice.tween_quat1 = dimdice.quaternion
	dimdice.dimdice_movement_started.connect(on_dimdice_movement_started)
	dimdice.dimdice_movement_finished.connect(func(): controls.disabled = false)
	dimdice.dimension_started.connect(on_dimension_started)
	dimdice.dimension_finished.connect(on_dimension_finished)
	# add dimdice and net
	Globals.dungeon.dimdice = dimdice
	Globals.dungeon.set_dimnet(player_gui.net, dimcoor)

func on_touch_released():
	var object = controls.touched_object
	print(object)
	if not object: # object is null, nothing was touched
		return
	elif object in Globals.dungeon.base_tiles: # if object is base tile
		on_base_tile_touched(object)
	elif object.collision_layer == Globals.LAYERS.PATH_TILES: # if object is path tile
		on_path_tile_touched(object)
	elif object.collision_layer == Globals.LAYERS.SUMMONS: # if object is summon
		on_summon_touched(object)

func on_base_tile_touched(tile):
	# if dimdice exists, i.e. if in dimension state and dimdice selected
	if Globals.dungeon.dimdice:
		dimdice_position = tile.global_position
		dimdice_position.y += DIMDICE_Y_POSITION
		dimcoor = Globals.dungeon.get_tilecoor(tile)
		Globals.dungeon.on_tile_touched(tile, dimdice_position, player_gui.net)
	# case dungeon state
	elif player_gui.state == Globals.GUI_STATE.DUNGEON:
		if gui_substate == GUI_SUBSTATE.INIT:
			deactivate_dungeon_buttons()
			deactivate_summon_info.emit()

func on_path_tile_touched(tile):
	# case dungeon state
	if player_gui.state == Globals.GUI_STATE.DUNGEON:
		if gui_substate == GUI_SUBSTATE.MOVE:
			activate_selected_move_path(tile)
		else:
			on_base_tile_touched(tile.base_tile)
	# if not an implemented case, default to base tile behavior
	else:
		on_base_tile_touched(tile.base_tile)

func on_summon_touched(summon):
	summon_touched.emit(summon)
	if player_gui.state == Globals.GUI_STATE.DUNGEON:
		if gui_substate == GUI_SUBSTATE.INIT:
			if summon.type != "ITEM" and summon.player == player_gui.player:
				selected_monster = summon
				activate_dungeon_buttons()
			else:
				deactivate_dungeon_buttons()

func on_dragging(length, angle):
	var dimdice = Globals.dungeon.dimdice
	if dimdice and controls.touched_object == dimdice:
		if dimdice_dragging:
			move_dimdice()
		elif length > DIMDICE_DRAG_THRESHOLD:
			drag_dice(angle)
	else:
		move_camera()

func on_drag_released():
	if dimdice_dragging:
		dimdice_dragging = false
		Globals.dungeon.return_dimdice(dimdice_position)

func on_dimdice_movement_started():
	dimdice_dragging = false
	controls.disabled = true

func on_dimension_started():
	controls.disabled = true
	player_gui.on_dimension_started(Globals.dungeon.dimdice)

func on_dimension_finished():
	dimdice_dragging = false
	controls.disabled = false
	player_gui.state = Globals.GUI_STATE.DUNGEON

func on_switched_to_dungeon_state():
	Globals.dungeon.remove_dimdice()
	%EndTurn.visible = true

func _on_camera_reset_pressed() -> void:
	%CameraReset.visible = false
	player_gui.duel_camera.on_camera_reset_pressed()
	controls.disabled = false

func on_cancel_button_pressed():
	gui_substate = GUI_SUBSTATE.INIT
	Globals.dungeon.remove_tiles_highlight()
	selected_monster = null
	move_path = null
	%EndTurn.visible = true
	dungeon_cancel_button_pressed.emit()

func on_move_action_started():
	gui_substate = GUI_SUBSTATE.MOVE
	Globals.dungeon.activate_move_tiles(selected_monster)

func on_attack_action_started():
	gui_substate = GUI_SUBSTATE.ATTACK
	Globals.dungeon.activate_attack_tiles(selected_monster)

func on_move_path_confirmed():
	monster_moved.emit(dungeon_buttons.get_move_cost())
	await Globals.dungeon.move_monster(selected_monster, move_path)
	gui_substate = GUI_SUBSTATE.INIT
	%EndTurn.visible = true

func _on_end_turn_pressed() -> void:
	%EndTurn.visible = false
	player_gui.endturn_pressed.emit(player_gui.player)
#endregion

#region private functions
func drag_dice(angle):
	if -135 < angle and angle < -45:
		dimdice_dragging = true
	else:
		if angle <= -135 or 135 < angle:
			rotate_dimdice_clockwise()
		elif -45 <= angle and angle < 45:
			rotate_dimdice_counter_clockwise()
		elif 45 <= angle and angle < 135:
			flip_dimdice()

func rotate_dimdice_clockwise():
	Globals.dungeon.rotate_dimdice_clockwise()
	player_gui.net.rotate_clockwise()
	Globals.dungeon.set_dimnet(player_gui.net, dimcoor)

func rotate_dimdice_counter_clockwise():
	Globals.dungeon.rotate_dimdice_counter_clockwise()
	player_gui.net.rotate_counter_clockwise()
	Globals.dungeon.set_dimnet(player_gui.net, dimcoor)

func flip_dimdice():
	Globals.dungeon.flip_dimdice(player_gui.player)
	player_gui.net.flip()
	Globals.dungeon.set_dimnet(player_gui.net, dimcoor)

func move_dimdice():
	var velocity = controls.velocity
	var player = player_gui.player
	var net = player_gui.net
	Globals.dungeon.move_dimdice(velocity, player, net, dimdice_position)

func move_camera():
	player_gui.duel_camera.pan(controls.velocity)

func on_pinching(factor):
	player_gui.duel_camera.zoom(factor)

func activate_dungeon_buttons():
	dungeon_buttons.activate(player_gui.dice_gui.crestpool)
	%EndTurn.visible = false

func deactivate_dungeon_buttons():
	dungeon_buttons.deactivate()
	%EndTurn.visible = true

func activate_selected_move_path(tile):
	gui_substate = GUI_SUBSTATE.MOVE2
	move_path = Globals.dungeon.activate_selected_move_path(selected_monster, tile.base_tile)
	var move_cost = Globals.dungeon.get_move_cost(move_path, selected_monster)
	dungeon_buttons.on_move_path_selected(move_cost)
#endregion
