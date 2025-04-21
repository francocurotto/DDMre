extends PanelContainer

#region public functions
func update_dice(dice_buttons):
	# remove previous dice
	for dice in %DiceList.get_children():
		dice.queue_free()
	# add new dice
	for dice_button in dice_buttons:
		%DiceList.add_child(dice_button.dice.duplicate())
#endregion
