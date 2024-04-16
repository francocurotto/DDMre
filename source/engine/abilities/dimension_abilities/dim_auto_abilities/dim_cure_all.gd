extends "dim_auto_ability.gd"
## DIMCUREALL ability.
##
## Cure a certain amount of health to all player monsters during monster
## dimension.

#region variables
var amount ## Amount of health to heal.
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    amount = ability_dict["AMOUNT"]
#endregion

#region public functions
## Activate ability. Cure player monsters.
func activate():
    for monster in summon.player.monsters:
        monster.restore_health(amount)
#endregion
