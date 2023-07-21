extends "res://engine/abilities/reply_ability.gd"

# variables
var COST
var CREST

func _init(ability_dict).(ability_dict):
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(_attacker, _activate_dict):
    """
    Add temporal limit to damage behavior.
    """
    .activate(_attacker, _activate_dict)
    pay_crests(CREST, COST)
    summon.damage_behavior.add_limit(0)

func deactivate():
    .deactivate()
    summon.damage_behavior.remove_limit(0)
