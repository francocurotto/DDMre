extends "base_ability.gd"

# variables
var max_raise

func _init(ability_dict).(ability_dict):
    max_raise = ability_dict["MAX"]

# public functions
func activate(ability_dict):
    """
    Add temporal buff to power behavior.
    """
    summon.power_behavior.ability_buff += 10*ability_dict["raise"]
