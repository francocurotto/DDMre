extends "res://engine/abilities/standing_ability.gd"

# variables
var AMOUNT
var COST
var CREST

func _init(ability_dict).(ability_dict):
    AMOUNT = ability_dict["AMOUNT"]
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    """
    Trade health with opponent monster in pos.
    """
    pay_crests(CREST, COST)
    var monster = dungeon.get_tile(activate_dict["pos"]).content
    monster.receive_damage(AMOUNT)
    summon.receive_damage(AMOUNT)

func get_select_tiles():
    return get_opponent_monsters_tiles()
