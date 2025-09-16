extends Camera3D

#region signals
signal camera_moved
#endregion

#region constants
const PAN_SPEED = 0.05
const ZOOM_SPEED = 400
const CAMERA_POSITION = {1: Vector3(0, 5, 4), 2: Vector3(0, 5, -22)}
const CAMERA_ROTATION = {1: Vector3(-PI/4, 0, 0), 2: Vector3(-3*PI/4, 0, PI)}
#endregion

#region public variables
var player : int = 1 :
	set(_player):
		player = _player
		position = CAMERA_POSITION[player]
		rotation = CAMERA_ROTATION[player]
#endregion

#region private variables
var init_position
#endregion

#region builtin functions
func _ready() -> void:
	init_position = position
#endregion

#region public functions
func pan(velocity):
	var delta = get_process_delta_time()
	var multiplier = 2*player - 3
	var movement = Vector3(velocity.x, 0, velocity.y)
	var delta_position = multiplier * PAN_SPEED * movement * delta
	var tween = create_tween()
	tween.tween_property(self, "position", position + delta_position, 0.1)
	camera_moved.emit()

func zoom(factor):
	var delta = get_process_delta_time()
	var delta_position = transform.basis.z * ZOOM_SPEED * factor * delta
	var tween = create_tween()
	tween.tween_property(self, "position", position + delta_position, 0.1)
	camera_moved.emit()
#endregion

#region signals callback
func on_camera_reset_pressed():
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "position", init_position, 1)
#endregion
