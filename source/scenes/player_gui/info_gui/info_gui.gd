extends VBoxContainer

#region builtin functions
func _ready() -> void:
	deactivate_info()
#endregion

#region signals callbacks
func on_dicegui_tab_changed():
	deactivate_info()

func on_dice_button_focused(dice):
	activate_dice_info(dice)

func on_dimdice_selected(dice):
	activate_dice_info(dice)

func on_summon_touched(summon):
	activate_summon_info(summon)

func on_dimension_started():
	deactivate_info()
#endregion

#region private functions
func activate_dice_info(dice):
	$TabContainer.current_tab = 0
	$TabContainer.set_tab_disabled(0, false)
	%"Summon Info".set_dice_info(dice)

func activate_summon_info(summon):
	$TabContainer.current_tab = 0
	$TabContainer.set_tab_disabled(0, false)
	%"Summon Info".set_summon_info(summon)

func deactivate_info():
	$TabContainer.current_tab = -1
	$TabContainer.set_tab_disabled(0, true)
#endregion
