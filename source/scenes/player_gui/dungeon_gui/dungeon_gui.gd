extends Control

#region constants
const CAMERA_SPEED = 0.0004
#endregion

#region public variables
var state
#endregion

#region private variables
var dragging = false
#endregion

#region builtin functions
func _input(event):
	if get_global_rect().has_point(event.position):
		if event is InputEventScreenDrag:
			dragging = true
			input_drag(event)
		elif event is InputEventScreenTouch and not event.pressed:
			dragging = false
			if not dragging: # check if it was not dragging input
				input_touch(event)
#endregion

#region private functions
func input_drag(event):
	# move camera
	var movement = Vector3(event.velocity.x, 0, event.velocity.y)
	Globals.duel_camera.position -= CAMERA_SPEED * movement

func input_touch(_event):
	pass
	#Globals.dungeon.dungeon_touch(event)
#endregion
