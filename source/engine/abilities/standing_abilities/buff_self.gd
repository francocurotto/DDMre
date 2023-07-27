extends "res://engine/abilities/standing_ability.gd"

# variables
var attr
var amount
var cost
var crest

func _init(ability_dict):
    super(ability_dict)
    attr = ability_dict["ATTR"]
    amount = ability_dict["AMOUNT"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(_activate_dict):
    """
    Buff monster attr by amount.
    """
    pay_crests(crest, cost)
    summon.buff_attr(attr, amount)
