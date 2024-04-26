extends "item_ability.gd"
## ITEMBUFF ability.
##
## Buff an attribute of monster in certain amount.

#region variables
var attr   ## Attribute to buff
var amount ## Amount by which the attribute is increased
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    attr = ability_dict["ATTR"]
    amount = ability_dict["AMOUNT"]
#endregion

#region public functions
## Activate ability. Buff the attribute of [param monster].
func activate(monster):
    monster.buff_attr(attr, amount)
#endregion
