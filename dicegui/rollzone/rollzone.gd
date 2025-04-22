extends PanelContainer

#region constants
var DICEPOS = [Vector3(-2.5,0,0), Vector3(0,0,0), Vector3(2.5,0,0)]
#endregion

#region private variables
var dragging = false
var roll_velocity = Vector2.ZERO
#endregion

#region builtin functions
func _input(event):
	var rollzone_selected = get_parent().current_tab == 2
	# check if roll completed
	if len(%DiceList.get_children()) >= 3:
		# check for touch or drag
			if event is InputEventScreenTouch or event is InputEventScreenDrag:
				# Check if the touch is inside the drag area
				if get_global_rect().has_point(event.position) and rollzone_selected:
					# if touch, dragging started
					if event is InputEventScreenTouch and event.pressed:
						dragging = true
					# if drag, register velocity
					elif event is InputEventScreenDrag and dragging:
						roll_velocity = event.velocity
					# if drag released, roll dice
					elif event is InputEventScreenTouch and not event.pressed and dragging:
						for dice in %DiceList.get_children():
							dice.gravity_scale = 1
						print("ROLL!: " + str(roll_velocity))
						dragging = false
						roll_velocity = Vector2.ZERO
				# if outside the drag area, reset dragging
				else:
					dragging = false
					roll_velocity = Vector2.ZERO

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
