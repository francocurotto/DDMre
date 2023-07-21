extends "res://engine/abilities/standing_ability.gd"

# variables
var COST
var CREST
var monster

func _init(ability_dict).(ability_dict):
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    """
    Mind control.
    """
    pay_crests(CREST, COST)
    monster = dungeon.get_tile(activate_dict["pos"]).content
    monster.switch_player()
    Events.connect("next_turn", self, "on_next_turn")

func get_select_tiles():
    return get_opponent_monsters_tiles()

# signals callbacks
func on_next_turn(_player, _turn):
    monster.switch_player()
    Events.disconnect("next_turn", self, "on_next_turn")
