extends PanelContainer

#region constants
var DICEPOS = [Vector3(-2.5,0,0), Vector3(0,0,0), Vector3(2.5,0,0)]
#endregion

#region private variables
var dragging = false ## true when player is dragging for roll
var roll_flag = true ## false to disable roll (e.g. right after the roll)
var roll_counter = 0 ## Counts how many dice have stopped rolling
var roll_velocity = Vector2.ZERO ## Initial velocity of roll
var roll_ready : bool = false : ## true when player is allowed to roll
	get():
		var three_dice = len(%DiceList.get_children()) >= 3
		var tab_selected = get_parent().current_tab == 2
		return three_dice and tab_selected and roll_flag
#endregion

#region builtin functions
func _input(event):
	if roll_ready:
		# check for touch or drag
		if event is InputEventScreenTouch or event is InputEventScreenDrag:
			# Check if the touch is inside the drag area
			if get_global_rect().has_point(event.position):
				# if touch, dragging started
				if event is InputEventScreenTouch and event.pressed:
					dragging = true
				# if drag, register velocity
				elif event is InputEventScreenDrag and dragging:
					roll_velocity = event.velocity
				# if drag released, roll dice
				elif event is InputEventScreenTouch and not event.pressed and dragging:
					roll_dice(roll_velocity)
					reset_dragging()
			# if outside the drag area, reset dragging
			else:
				reset_dragging()
#endregion

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
		dice.roll_stopped.connect(on_roll_stopped)
#endregion

#region signals callbacks
func on_roll_stopped():
	roll_counter += 1
	if roll_counter >= 3:
		print("ROLL FINISHED!")
#endregion

#region private functions
func reset_dragging():
	dragging = false
	roll_velocity = Vector2.ZERO

func roll_dice(velocity):
	# disable further rolling
	roll_flag = false
	for dice in %DiceList.get_children():
		dice.roll(velocity)
#endregion
