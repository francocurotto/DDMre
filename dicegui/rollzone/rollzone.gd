extends PanelContainer

#region constants
var DICEPOS = [Vector3(-2.5,0,0), Vector3(0,0,0), Vector3(2.5,0,0)]
#endregion

#region private variables
var dragging = false
var drag_position
#endregion

#region builtin functions
func _input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		var pos = event.position
		# Check if the touch is inside the drag area
		if get_global_rect().has_point(pos):
			if event is InputEventScreenTouch and event.pressed:
				dragging = true
				drag_position = pos
			elif event is InputEventScreenDrag and dragging:
				drag_position = pos
			if event is InputEventScreenTouch and not event.pressed:
				dragging = false
				print("pos1: " + str(pos))
				print("pos2: " +str(pos))
		else:
			dragging = false

#region public functions
func update_dice(dice_buttons):
	# remove previous dice
	for dice in %DiceList.get_children():
		dice.queue_free()
	# add new dice
	for i in len(dice_buttons):
		var dice = dice_buttons[i].dice.duplicate()
		%DiceList.add_child(dice)
		dice.position = DICEPOS[i]
#endregion
