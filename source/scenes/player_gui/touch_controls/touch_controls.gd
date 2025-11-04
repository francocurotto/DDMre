extends Control

#region signals
signal touch_pressed
signal dragging
signal touch_released
signal drag_released
signal pinching
#endregion

#region export variables
@export var disabled : bool = false : 
	set(_disabled):
		disabled = _disabled
		if disabled:
			reset_flags()
#endregion

#region public variables
var touch_position : Vector2
var velocity : Vector2
var viewport : Viewport
var camera3d : Camera3D
var mask : int = 4294967295
var touched_object : Object
#endregion

#region private variables
var touch_flag : bool = false ## true if touched
var drag_flag : bool = false ## true if dragging
var threshold_flag : bool = false ## true if threshold was exceeded
#endregion

#region builtin functions
func _gui_input(event: InputEvent) -> void:
	if not disabled:
		if event is InputEventScreenTouch and event.pressed:
			if get_rect().has_point(event.position):
				if event.index == 0:
					touch_flag = true
					touch_position = viewport.get_mouse_position()
					touched_object = get_touched_object()
					touch_pressed.emit()
				else:
					reset_flags()
		elif event is InputEventScreenDrag and touch_flag:
			drag_flag = true
			velocity = event.velocity
			dragging.emit(get_drag_length(), get_drag_angle(event))
		elif event is InputEventScreenTouch and not event.pressed and touch_flag:
			if drag_flag:
				drag_released.emit()
			elif touch_flag:
				touch_released.emit()
			reset_flags()
		elif event is InputEventMagnifyGesture:
			pinching.emit(-log(event.factor))
		elif event is InputEventMouseButton:
			if event.pressed:
				match event.button_index:
					MOUSE_BUTTON_WHEEL_UP:
						pinching.emit(-0.1)
					MOUSE_BUTTON_WHEEL_DOWN:
						pinching.emit(0.1)
#endregion

#region public functions
func set_raycast(_viewport, _camera3d):
	viewport = _viewport
	camera3d = _camera3d
#endregion

#region private functions
func reset_flags():
	touch_flag = false
	drag_flag = false
	threshold_flag = false

func get_touched_object():
	var ray_origin = camera3d.project_ray_origin(touch_position)
	var ray_target = ray_origin + camera3d.project_ray_normal(touch_position) * 1000
	var space_state = camera3d.get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_target, mask)
	var result = space_state.intersect_ray(query)
	if result:
		return result["collider"]

func get_drag_length():
	return  viewport.get_mouse_position().distance_to(touch_position)

func get_drag_angle(event):
	return rad_to_deg(-touch_position.angle_to_point(event.position))
#endregion
