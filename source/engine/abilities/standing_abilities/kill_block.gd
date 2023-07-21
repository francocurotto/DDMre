extends "res://engine/abilities/standing_ability.gd"

# variables
var COST
var CREST

func _init(ability_dict).(ability_dict):
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    """
    Kill block.
    """
    pay_crests(CREST, COST)
    dungeon.place_open_tile(activate_dict["pos"])

func get_select_tiles():
    return get_block_tiles()
