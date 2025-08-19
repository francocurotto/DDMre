extends Camera3D

#region constants
const PAN_SPEED = 0.02
const ZOOM_SPEED = 0.2
#endregion

func _ready() -> void:
	print(transform.basis.z)

#region public functions
func pan(velocity):
	var delta = get_process_delta_time()
	var movement = Vector3(velocity.x, 0, velocity.y)
	var delta_position = -1 * PAN_SPEED * movement * delta
	Globals.duel_camera.position += delta_position

func zoom(zoom_force):
	var delta = get_process_delta_time()
	position += transform.basis.z * ZOOM_SPEED * zoom_force * delta
#endregion
