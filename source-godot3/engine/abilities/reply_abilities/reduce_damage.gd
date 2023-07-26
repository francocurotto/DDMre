extends "res://engine/abilities/reply_ability.gd"

# variables
var amount
var cost
var crest

func _init(ability_dict).(ability_dict):
    amount = ability_dict["AMOUNT"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(_attacker, _activate_dict):
    """
    Add temporal reduce to damage behavior.
    """
    .activate(_attacker, _activate_dict)
    pay_crests(crest, cost)
    summon.damage_behavior.ability_reduce += amount

func deactivate():
    .deactivate()
    summon.damage_behavior.ability_reduce = 0
