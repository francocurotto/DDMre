extends "res://engine/abilities/attack_ability.gd"

# variables
var MAX

func _init(ability_dict).(ability_dict):
    MAX = ability_dict["MAX"]

# public functions
func activate(activate_dict):
    """
    Add temporal buff to power behavior.
    """
    .activate(activate_dict)
    var raise = activate_dict["raise"]
    pay_crests("ATTACK", raise)
    summon.power_behavior.ability_buff += 10*raise

func deactivate():
    .deactivate()
    summon.power_behavior.ability_buff = 0
