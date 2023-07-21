extends "res://engine/abilities/standing_ability.gd"

# variables
var ATTR
var AMOUNT
var COST
var CREST

func _init(ability_dict).(ability_dict):
    ATTR = ability_dict["ATTR"]
    AMOUNT = ability_dict["AMOUNT"]
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(_activate_dict):
    """
    Buff monster attr by amount.
    """
    summon.player.crestpool.remove_crests(CREST, COST)
    summon.buff_attr(ATTR.to_lower(), AMOUNT)
