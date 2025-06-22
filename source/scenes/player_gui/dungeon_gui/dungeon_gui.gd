extends Control

#region constants
const CAMERA_SPEED = 0.02
#endregion

#region public variables
var guistate
#endregion

#region private variables
var touched_dice
var first_drag = false
var dragging = false
#endregion

#region builtin functions
func _input(event):
	if get_global_rect().has_point(event.position):
		if event is InputEventScreenTouch and event.pressed:
			touched_dice = Globals.dungeon.get_touched_object(event, Globals.LAYERS.DICE)
			first_drag = true
		if event is InputEventScreenDrag:
			dragging = true
			input_drag(event)
			first_drag = false
		elif event is InputEventScreenTouch and not event.pressed:
			if not dragging: # check if it was not dragging input
				input_touch(event)
			first_drag = false
			dragging = false
			touched_dice = null
#endregion

#region private functions
func input_drag(event):
	if touched_dice: # dragging dice
		drag_dice(event)
	else: # dragging everything else
		move_camera(event)

func input_touch(event):
	var tile = Globals.dungeon.get_touched_object(event, Globals.LAYERS.TILES)
	if tile:
		Globals.dungeon.dungeon_touch(tile)

func drag_dice(event):
	var angle = event.velocity.angle()
	if angle <= -0.75*PI or 0.75*PI < angle:
		if first_drag:
			rotate_dimdice_counter_clockwise()
	elif -0.25*PI <= angle and angle < 0.25*PI:
		if first_drag:
			rotate_dimdice_clockwise()
	elif 0.25*PI <= angle and angle < 0.75*PI:
		if first_drag:
			flip_dimdice()
	else:
		move_dimdice()

func rotate_dimdice_clockwise():
	Net.rotate_clockwise()
	Globals.dungeon.set_dimnet()

func rotate_dimdice_counter_clockwise():
	Net.rotate_counter_clockwise()
	Globals.dungeon.set_dimnet()

func flip_dimdice():
	Net.flip()
	Globals.dungeon.set_dimnet()

func move_dimdice():
	pass

func move_camera(event):
	var movement = Vector3(event.velocity.x, 0, event.velocity.y)
	Globals.duel_camera.position -= CAMERA_SPEED * movement * get_process_delta_time()
#endregion
