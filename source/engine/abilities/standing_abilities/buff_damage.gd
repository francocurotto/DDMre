extends "res://engine/abilities/standing_ability.gd"

# variables
var ATTR
var COST
var CREST

func _init(ability_dict).(ability_dict):
    ATTR = ability_dict["ATTR"]
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(_activate_dict):
    """
    Buff monster attr by damage.
    """
    pay_crests(CREST, COST)
    var damage = summon.card.health - summon.health
    summon.buff_attr(ATTR.to_lower(), damage)
