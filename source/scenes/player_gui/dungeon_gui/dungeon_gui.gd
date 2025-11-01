extends Control

#region signals
signal summon_touched
#endregion

#region constants
const DIMDICE_Y_POSITION = 2
const DIMDICE_DRAG_THRESHOLD = 10
const DIMDICE_INIT_ROTATION = {1: Vector3(0,0,0), 2: Vector3(0, PI, 0)}
#endregion

#region public variables
var player_gui
var duel_camera
#endregion

#region private variables
var dimdice_dragging = false
var dimdice_position : Vector3
var dimcoor : Vector2i
#endregion

#region onready variables
@onready var controls = $TouchControls
@onready var camera_reset = %CameraReset
#endregion

#region builtin functions
func _ready() -> void:
	controls.mask = Globals.LAYERS.DICE + \
		Globals.LAYERS.BASE_TILES + \
		Globals.LAYERS.SUMMONS
	controls.set_raycast(get_viewport(), duel_camera)
	controls.touch_released.connect(on_touch_released)
	controls.dragging.connect(on_dragging)
	controls.drag_released.connect(on_drag_released)
	controls.pinching.connect(on_pinching)
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
	if object and object.collision_layer == Globals.LAYERS.SUMMONS:
		summon_touched.emit(object)
	elif Globals.dungeon.dimdice and object in Globals.dungeon.tiles:
		var tile = object
		dimdice_position = tile.global_position
		dimdice_position.y += DIMDICE_Y_POSITION
		dimcoor = Globals.dungeon.get_tilecoor(tile)
		Globals.dungeon.on_tile_touched(tile, dimdice_position, player_gui.net)

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
	duel_camera.on_camera_reset_pressed()
	controls.disabled = false

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
	duel_camera.pan(controls.velocity)

func on_pinching(factor):
	duel_camera.zoom(factor)
#endregion
