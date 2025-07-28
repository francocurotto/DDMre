extends VBoxContainer

#region builtin functions
func _ready() -> void:
	$TabContainer.current_tab = -1
#endregion

#region signals callbacks
func on_dicegui_tab_changed():
	$TabContainer.current_tab = -1

func on_dice_button_focused(dice):
	$TabContainer.current_tab = 0
	%"Summon Info".set_dice_info(dice)

func on_dimdice_selected(dice):
	$TabContainer.current_tab = 0
	%"Summon Info".set_dice_info(dice)

func on_dimension_started():
	$TabContainer.current_tab = -1
#endregion
