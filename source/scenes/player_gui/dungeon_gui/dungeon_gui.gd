extends Control

#region constants
const CAMERA_SPEED = 0.02
const DRAG_LENGTH = 10
#endregion

#region public functions
var player_gui
#endregion

#region private variables
var touched_dice
var touched_pos
var dragging = false
var drag_input_done = false
#endregion

#region onready variables
@onready var controls = $TouchControls
#endregion

#region builtin functions
func _ready() -> void:
	controls.set_raycast(get_viewport())
	controls.touch_released.connect(on_touch_released)
	controls.dragging.connect(on_dragging)
	controls.threshold_exceeded.connect(on_threshold_exceeded)
#endregion

#region signals callbacks
func on_touch_released():
	var tile = controls.get_touched_object(Globals.LAYERS.TILES)
	if tile:
		Globals.dungeon.dungeon_touch(tile, player_gui.net)

func on_dragging():
	if not controls.get_touched_object(Globals.LAYERS.DICE):
		move_camera()

func on_threshold_exceeded(angle):
	if controls.get_touched_object(Globals.LAYERS.DICE):
		drag_dice(angle)
#endregion

#region private functions
func drag_dice(angle):
	if angle <= -135 or 135 < angle:
		rotate_dimdice_clockwise()
	elif -45 <= angle and angle < 45:
		rotate_dimdice_counter_clockwise()
	elif 45 <= angle and angle < 135:
		flip_dimdice()
	elif -135 < angle and angle < -45:
		move_dimdice()

func rotate_dimdice_clockwise():
	Globals.dungeon.rotate_dimdice_clockwise()
	player_gui.net.rotate_clockwise()
	Globals.dungeon.set_dimnet(player_gui.net)

func rotate_dimdice_counter_clockwise():
	Globals.dungeon.rotate_dimdice_counter_clockwise()
	player_gui.net.rotate_counter_clockwise()
	Globals.dungeon.set_dimnet(player_gui.net)

func flip_dimdice():
	Globals.dungeon.flip_dimdice()
	player_gui.net.flip()
	Globals.dungeon.set_dimnet(player_gui.net)

func move_dimdice():
	pass

func move_camera():
	var movement = Vector3(controls.velocity.x, 0, controls.velocity.y)
	var delta_position = -1 * CAMERA_SPEED * movement * get_process_delta_time()
	Globals.duel_camera.position += delta_position
#endregion
