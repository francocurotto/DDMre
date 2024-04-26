extends "item_ability.gd"
## ITEMDAMAGE ability.
##
## Decrease in a certain amount the health points of monster.

#region variables
var amount ## Amount to damage
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    amount = ability_dict["AMOUNT"]
#endregion

#region public functions
## Activate ability. Reduce [param monster] health.
func activate(monster):
    monster.receive_damage(amount)
#endregion
