extends "continuous_ability.gd"
## RAISESPEED ability.
##
## Increase the movement speed of monster.

#region variables
var amount ## amount to set the speed of monster
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    amount = ability_dict["AMOUNT"]
#endregion

#region public functions
## Activate ability. Set monster speed to new value.
func activate():
    summon.speed = amount

## Deactivate ability. Reset monster speed to 1.
func deactivate():
    summon.speed = 1
#endregion
