extends "attack_ability.gd"

# variables
var max_raise

func _init(ability_dict):
    super(ability_dict)
    max_raise = ability_dict["MAX"]

# public functions
func activate(activate_dict):
    """
    Add temporal buff to power behavior.
    """
    super.activate(activate_dict)
    var raise = activate_dict["raise"]
    pay_crests("ATTACK", raise)
    summon.power_behavior.ability_buff += 10*raise

func deactivate():
    super.deactivate()
    summon.power_behavior.ability_buff = 0
