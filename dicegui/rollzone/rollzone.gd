extends PanelContainer

#region signals
signal crest_side_rolled
#endregion

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
			resolve_roll()
#endregion

#region private functions
func roll_dice(velocity):
	# disable further rolling
	state = STATE.ROLLING
	for dice in %DiceList.get_children():
		dice.roll(velocity)

func all_dice_stopped():
	return %DiceList.get_children().all(func(dice): return not dice.moving)

func any_dice_cocked():
	return %DiceList.get_children().any(func(dice): return dice.cocked)

func resolve_roll():
	var summon_dice = []
	# resolve crest rolls
	for dice in %DiceList.get_children():
		var side = dice.get_rolled_side()
		if side.type != "SUMMON":
			crest_side_rolled.emit(side)
			dice.remove()
		else:
			summon_dice.append(dice)
	# resolve summon rolls
	var dim_dice = []
	for level in range(1,4):
		dim_dice = []
		for dice in summon_dice:
			var side = dice.get_rolled_side()
			if side.level == level:
				dim_dice.append(dice)
		if len(dim_dice) >= 2:
			break
	print(dim_dice)
#endregion
