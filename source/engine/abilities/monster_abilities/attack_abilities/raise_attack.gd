extends "attack_ability.gd"
## RAISEATTACK ability.
##
## Temporarily increase attack power of monster during attack.

#region variables
var max_raise ## Max possible amount to raise attack power
#endregion

#region builtin function
func _init(ability_dict):
    super(ability_dict)
    max_raise = ability_dict["MAX"]
#endregion

#region public functions
## Activate ability using parameters [param activate_dict]. Add temporal buff 
## to power behavior.
func activate(activate_dict):
    super.activate(activate_dict)
    var raise = activate_dict["raise"]
    pay_crests("ATTACK", raise)
    summon.power_behavior.ability_buff += 10*raise

## Deactivate ability. Remove temporal buff.
func deactivate():
    super()
    summon.power_behavior.ability_buff = 0
#endregion
