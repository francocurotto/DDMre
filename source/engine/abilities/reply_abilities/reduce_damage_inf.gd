extends "res://engine/abilities/reply_ability.gd"

# variables
var crest = "DEFENSE"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate(_attacker, activate_dict):
    """
    Add temporal reduce to damage behavior.
    """
    .activate(_attacker, activate_dict)
    var reduce = activate_dict["reduce"]
    pay_crests(crest, reduce)
    summon.damage_behavior.ability_reduce += 10*reduce

func deactivate():
    .deactivate()
    summon.damage_behavior.ability_reduce = 0
