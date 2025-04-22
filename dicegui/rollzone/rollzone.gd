extends PanelContainer

#region constants
var DICEPOS = [Vector3(-2.5,0,0), Vector3(0,0,0), Vector3(2.5,0,0)]
#endregion

#region private variables
var dragging = false
var throw_velocity = Vector2.ZERO
#endregion

#region builtin functions
func _input(event):
	var rollzone_selected = get_parent().current_tab == 2
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		# Check if the touch is inside the drag area
		if get_global_rect().has_point(event.position) and rollzone_selected:
			if event is InputEventScreenTouch and event.pressed:
				dragging = true
			elif event is InputEventScreenDrag and dragging:
				throw_velocity = event.velocity
				print(str(throw_velocity))
			elif event is InputEventScreenTouch and not event.pressed and dragging:
				print("THROW!: " + str(throw_velocity))
				dragging = false
				throw_velocity = Vector2.ZERO
		else:
			dragging = false
			throw_velocity = Vector2.ZERO

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
