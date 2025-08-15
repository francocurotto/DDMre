extends VBoxContainer

#region builtin functions
func _ready() -> void:
	deactivate_summon_info()
#endregion

#region signals callbacks
func on_dicegui_tab_changed():
	deactivate_summon_info()

func on_dice_button_focused(dice):
	activate_summon_info(dice)

func on_dimdice_selected(dice):
	activate_summon_info(dice)

func on_dimension_started():
	deactivate_summon_info()
#endregion

#region private functions
func activate_summon_info(dice):
	$TabContainer.current_tab = 0
	$TabContainer.set_tab_disabled(0, false)
	%"Summon Info".set_dice_info(dice)

func deactivate_summon_info():
	$TabContainer.current_tab = -1
	$TabContainer.set_tab_disabled(0, true)
#endregion
