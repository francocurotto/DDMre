extends PanelContainer

#region constants
const DICEPOS = [Vector3(-2.5,0,0), Vector3(0,0,0), Vector3(2.5,0,0)]
enum STATE {
	NOTFULL,
	FULL,
	ROLLING,
	ROLLED
}
#endregion

#region private variables
var state = STATE.NOTFULL
var dragging = false ## true when player is dragging for roll
var roll_velocity = Vector2.ZERO ## Initial velocity of roll
#endregion

#region builtin functions
func _input(event):
	if state == STATE.FULL:
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
					dragging = false
			# if outside the drag area, reset dragging
			else:
				dragging = false
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
		dice.state = dice.STATE.PREROLL
		dice.roll_stopped.connect(on_dice_stopped)
	# update state
	if %DiceList.get_child_count() >= 3:
		state = STATE.FULL
	else:
		state = STATE.NOTFULL
#endregion

#region signals callbacks
func on_dice_stopped():
	if all_dice_stopped():
		if any_dice_cocked():
			state = STATE.FULL
		else:
			state = STATE.ROLLED
	#roll_counter += 1
	## if all dice stop rolling, get rolled sides
	#if roll_counter >= 3:
		#roll_counter = 0
		#var rolled_sides = []
		#for dice in %DiceList.get_children():
			#var rolled_side = dice.get_rolled_side()
			## append only if rolled side is not null
			#if rolled_side:
				#rolled_sides.append(rolled_side)
		## if rolled sides is not 3, get got a bad roll, allow reroll
		#if len(rolled_sides) < 3:
			#roll_flag = true
		## else finish roll
		#else:
			#finish_roll(rolled_sides)
#endregion

#region private functions
func roll_dice(velocity):
	# disable further rolling
	state = STATE.ROLLING
	for dice in %DiceList.get_children():
		dice.roll(velocity)

#func finish_roll(rolled_sides):
	#for side in rolled_sides:
		#print(side.type + ", " + str(side.mult))
#endregion
