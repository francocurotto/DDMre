extends Control

#region constants
const CAMERA_SPEED = 0.02
const DRAG_LENGTH = 10
#endregion

#region public functions
var playergui
#endregion

#region private variables
var touched_dice
var touched_pos
var dragging = false
var drag_input_done = false
#endregion

#region builtin functions
func _input(event):
	if get_global_rect().has_point(event.position):
		if event is InputEventScreenTouch and event.pressed:
			touched_dice = Globals.dungeon.get_touched_object(event, Globals.LAYERS.DICE)
			touched_pos = event.position
		if event is InputEventScreenDrag:
			dragging = true
			input_drag(event)
		elif event is InputEventScreenTouch and not event.pressed:
			if not dragging: # check if it was not dragging input
				input_touch(event)
			dragging = false
			drag_input_done = false
			touched_pos = null
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
		Globals.dungeon.dungeon_touch(tile, playergui.net)

func drag_dice(event):
	var angle = rad_to_deg(-touched_pos.angle_to_point(event.position))
	if not drag_input_done:
		if event.position.distance_to(touched_pos) > DRAG_LENGTH:
			if angle <= -135 or 135 < angle:
				print(angle)
				rotate_dimdice_clockwise()
				drag_input_done = true
			elif -45 <= angle and angle < 45:
				print(angle)
				rotate_dimdice_counter_clockwise()
				drag_input_done = true
			elif 45 <= angle and angle < 135:
				print(angle)
				flip_dimdice()
				drag_input_done = true
		#if -135 < angle and angle < -45:
		#	move_dimdice()

func rotate_dimdice_clockwise():
	playergui.net.rotate_clockwise()
	Globals.dungeon.set_dimnet(playergui.net)

func rotate_dimdice_counter_clockwise():
	playergui.net.rotate_counter_clockwise()
	Globals.dungeon.set_dimnet(playergui.net)

func flip_dimdice():
	playergui.net.flip()
	Globals.dungeon.set_dimnet(playergui.net)

func move_dimdice():
	pass

func move_camera(event):
	var movement = Vector3(event.velocity.x, 0, event.velocity.y)
	Globals.duel_camera.position -= CAMERA_SPEED * movement * get_process_delta_time()
#endregion
