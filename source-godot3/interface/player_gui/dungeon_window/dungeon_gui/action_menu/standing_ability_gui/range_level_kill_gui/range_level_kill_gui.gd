extends "res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/standing_ability_gui/select_summon_gui/select_summon_gui.gd"

# constants
const RangeLevelKillSelectTileGUI = preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/standing_ability_gui/range_level_kill_gui/select_tile_gui.tscn")

# public functions
func setup(standing_ability_gui, ability):
    select_tile_gui = RangeLevelKillSelectTileGUI.instance().setup(standing_ability_gui, ability)
    return self
