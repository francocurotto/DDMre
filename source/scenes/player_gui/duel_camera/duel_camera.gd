extends Camera3D

#region signals
signal camera_moved
#endregion

#region constants
const PAN_SPEED = 0.05
const ZOOM_SPEED = 400
#endregion

#region private variables
var init_position
#endregion

#region builtin functions
func _ready() -> void:
	Globals.duel_camera = self
	init_position = position
#endregion

#region public functions
func pan(velocity):
	var delta = get_process_delta_time()
	var movement = Vector3(velocity.x, 0, velocity.y)
	var delta_position = -1 * PAN_SPEED * movement * delta
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
