extends Control

#region constants
const CAMERA_SPEED = 0.02
#endregion

#region public variables
var state
#endregion

#region private variables
var touched_dice
var dragging = false
#endregion

#region builtin functions
func _input(event):
	if get_global_rect().has_point(event.position):
		if event is InputEventScreenTouch and event.pressed:
			touched_dice = Globals.dungeon.get_touched_object(event, Globals.LAYERS.DICE)
		if event is InputEventScreenDrag:
			dragging = true
			input_drag(event)
		elif event is InputEventScreenTouch and not event.pressed:
			if not dragging: # check if it was not dragging input
				input_touch(event)
			dragging = false
			touched_dice = null
#endregion

#region private functions
func input_drag(event):
	if touched_dice: # dragging dice
		drag_dice()
	else: # dragging everything else
		move_camera(event)

func input_touch(event):
	var tile = Globals.dungeon.get_touched_object(event, Globals.LAYERS.TILES)
	if tile:
		Globals.dungeon.dungeon_touch(tile)

func drag_dice():
	pass

func move_camera(event):
	var movement = Vector3(event.velocity.x, 0, event.velocity.y)
	Globals.duel_camera.position -= CAMERA_SPEED * movement * get_process_delta_time()
#endregion
