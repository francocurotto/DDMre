extends AspectRatioContainer

#region public functions
func set_dice(dice_dict):
	$MarginContainer/SubViewportContainer/SubViewport/Dice.set_dice(dice_dict)
#endregion

#region signals callbacks
func _on_button_pressed() -> void:
	print("Dice Button pressed")
#endregion
