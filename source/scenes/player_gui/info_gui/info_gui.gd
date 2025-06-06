extends VBoxContainer

#region builtin functions
func _ready() -> void:
	Events.dice_button_focus_entered.connect(on_dice_button_focus_entered)
	Events.dicegui_tab_changed.connect(on_dicegui_tab_changed)
#endregion

#region signals callbacks
func on_dice_button_focus_entered(dice):
	$TabContainer.current_tab = 1
	%"Summon Info".set_dice_info(dice)

func on_dicegui_tab_changed():
	$TabContainer.current_tab = 0
#endregion
