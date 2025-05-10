extends VBoxContainer

#region builtin functions
func _ready() -> void:
	Events.dice_button_focus_entered.connect(on_dice_button_focus_entered)
#endregion

#region signals callbacks
func on_dice_button_focus_entered(dice):
	$TabContainer.current_tab = 1
	%"Summon Info".set_dice_info(dice)
#endregion
