extends "res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/standing_ability_gui/select_tile_gui/select_tile_gui.gd"

# signals
signal ability_cost_changed(cost)

# public functions
func setup(standing_ability_gui, ability):
    connect("ability_cost_changed", standing_ability_gui, "on_ability_cost_changed")
    return .setup(standing_ability_gui, ability)

# signals callbacks
func on_select_tile_select_button_pressed(tile):
    .on_select_tile_select_button_pressed(tile)
    emit_signal("ability_cost_changed", ability.cost+tile.content.card.level)
