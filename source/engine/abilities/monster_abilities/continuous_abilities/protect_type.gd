extends "continuous_ability.gd"
## PROTECTTYPE ability.
##
## All monster of certain type does not receive damage while being attacked.

#region variables
var type ## Type of monsters to protect
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    type = ability_dict["TYPE"]
#endregion

#region public functions
## Activate ability. Add zero limit to damage behavior of all monsters of 
## defined type.
func activate():
    super()
    for monster in dungeon.monsters:
        if monster.TYPE == type:
            monster.damage_behavior.add_limit(0)

## Deactivate ability. Remove zero limit in damage behavior of all monsters of 
## defined type.
func deactivate():
    super()
    for monster in dungeon.monsters:
        if monster.TYPE == type:
            monster.damage_behavior.remove_limit(0)
#endregion

#region signals callbacks
## When a new summon occurs, add zero limit to damage behavior of monster if 
## is of defined type.
func on_new_summon(_summon, _net):
    if _summon.TYPE == type:
        _summon.damage_behavior.add_limit(0)
#endregion
