extends "res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/reply_gui/button_gui/button_gui.gd"

# private functions
func get_button_text():
    return "✨%s -%d (%d%s)" % [Globals.ABIDICT[ability.name]["NAME"], ability.AMOUNT, ability.COST, Globals.CRESTICONS[ability.CREST]]
            
