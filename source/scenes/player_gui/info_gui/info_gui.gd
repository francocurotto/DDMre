extends VBoxContainer

#region signals callbacks
func on_dice_button_focused(dice):
	$TabContainer.current_tab = 0
	%"Summon Info".set_dice_info(dice)

func on_dicegui_tab_changed():
	$TabContainer.current_tab = -1
#endregion
