extends Control

#region variables
var dragging = false
#endregion

#region builtin functions
func _input(event):
	if event is InputEventScreenDrag:
		dragging = true
		# Check if the touch is inside the drag area
		if get_global_rect().has_point(event.position):
			var movement = Vector3(event.velocity.x, 0, event.velocity.y)
			Globals.duel_camera.position -= 0.0004 * movement
	elif event is InputEventScreenTouch and not event.pressed:
		if not dragging: # check if it was not dragging input
			Globals.dungeon.dungeon_touch(event)
		dragging = false
#endregion
