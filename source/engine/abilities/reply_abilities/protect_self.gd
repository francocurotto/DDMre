extends "res://engine/abilities/reply_ability.gd"

# variables
var cost
var crest

func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(_attacker, _activate_dict):
    """
    Add temporal limit to damage behavior.
    """
    super.activate(_attacker, _activate_dict)
    pay_crests(crest, cost)
    summon.damage_behavior.add_limit(0)

func deactivate():
    super.deactivate()
    summon.damage_behavior.remove_limit(0)
