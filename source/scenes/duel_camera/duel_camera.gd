extends Camera3D

#region constants
const PAN_SPEED = 0.05
const ZOOM_SPEED = 40
#endregion

#region public functions
func pan(velocity):
	var delta = get_process_delta_time()
	var movement = Vector3(velocity.x, 0, velocity.y)
	var delta_position = -1 * PAN_SPEED * movement * delta
	var tween = create_tween()
	tween.tween_property(self, "position", position + delta_position, 0.1)

func zoom(factor):
	var delta = get_process_delta_time()
	var delta_position = transform.basis.z * ZOOM_SPEED * factor * delta
	var tween = create_tween()
	tween.tween_property(self, "position", position + delta_position, 0.1)
#endregion
