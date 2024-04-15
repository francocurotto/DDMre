extends "res://engine/abilities/standing_ability.gd"

# variables
var attr
var cost
var crest

func _init(ability_dict):
    super(ability_dict)
    attr = ability_dict["ATTR"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(_activate_dict):
    """
    Buff monster attr by damage.
    """
    pay_crests(crest, cost)
    var damage = summon.card.health - summon.health
    summon.buff_attr(attr, damage)
