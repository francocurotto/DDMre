extends "res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/reply_gui/button_gui/button_gui.gd"

# private functions
func get_button_text():
    return "✨%s -%d (%d%s)" % [ability.name, ability.amount, ability.cost, Globals.CRESTICONS[ability.crest]]
            
