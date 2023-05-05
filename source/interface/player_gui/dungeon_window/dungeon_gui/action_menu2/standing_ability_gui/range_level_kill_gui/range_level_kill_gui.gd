extends "res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/standing_ability_gui/select_summon_gui/select_summon_gui.gd"

# private functions
func get_ability_cost(tile):
    return ability.cost + tile.content.card.level
