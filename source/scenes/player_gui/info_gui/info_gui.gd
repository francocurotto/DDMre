extends TabContainer
#region public variables
var player_gui
#endregion

#region builtin functions
func _ready() -> void:
	player_gui = find_parent("PlayerGUI?")
	deactivate_info()
#endregion

#region signals callbacks
func on_dicegui_tab_changed():
	deactivate_info()

func on_dice_button_focused(dice):
	activate_dice_info(dice)

func on_dimdice_selected(dice):
	activate_dice_info(dice)

func on_tile_touched():
	deactivate_info()

func on_summon_touched(summon):
	activate_summon_info(summon)

func on_dungeon_cancel_button_pressed():
	deactivate_info()

func on_dimension_started():
	deactivate_info()
#endregion

#region private functions
func activate_dice_info(dice):
	current_tab = 0
	set_tab_disabled(0, false)
	$"Summon Info".set_dice_info(dice)

func activate_summon_info(summon):
	current_tab = 0
	set_tab_disabled(0, false)
	$"Summon Info".set_summon_info(player_gui.player, summon)

func deactivate_info():
	current_tab = -1
	set_tab_disabled(0, true)
#endregion
