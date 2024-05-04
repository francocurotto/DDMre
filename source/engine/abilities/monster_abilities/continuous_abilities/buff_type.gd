extends "continuous_ability.gd"
## BUFFTYPE ability.
##
## Buff an attribute of all monster of a certain type, by a specific amount.

#region variables
var type   ## Type of monsters to buff
var attr   ## Attribute of monsters to buff
var amount ## Amount to buff to all monsters
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    type = ability_dict["TYPE"]
    attr = ability_dict["ATTR"]
    amount = ability_dict["AMOUNT"]
#endregion

#region public functions
## Activate ability. Buff all monsters of defined type.
func activate():
    super()
    for monster in dungeon.monsters:
        if monster.TYPE == type:
            monster.buff_attr(attr, amount)

## Deactivate ability. Remove buff in all monsters of defined type.
func deactivate():
    super()
    for monster in dungeon.monsters:
        if monster.TYPE == type:
            monster.debuff_attr(attr, amount)
#endregion

#region signals callbacks
## When a new summon occurs, buff monster if is of defined type.
func on_new_summon(_summon, _net):
    if _summon.TYPE == type:
        _summon.buff_attr(attr, amount)
#endregion
