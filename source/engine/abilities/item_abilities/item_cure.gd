extends "item_ability.gd"
## ITEMCURE ability.
##
## Increase a certain amount the heath points of monster.

#region variables
var amount ## Amount to cure
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    amount = ability_dict["AMOUNT"]
#endregion

#region public functions
## Activate ability. Cure [param monster] health.
func activate(monster):
    monster.restore_health(amount)
#endregion
