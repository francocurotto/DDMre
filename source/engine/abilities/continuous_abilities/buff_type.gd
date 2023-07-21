extends "res://engine/abilities/continuous_ability.gd"

# variables
var MTYPE
var ATTR
var AMOUNT

func _init(ability_dict).(ability_dict):
    MTYPE = ability_dict["MTYPE"]
    ATTR = ability_dict["ATTR"]
    AMOUNT = ability_dict["AMOUNT"]

# public functions
func activate():
    .activate()
    #GODOT4: use array filter
    for monster in dungeon.monsters:
        if monster.TYPE == MTYPE:
            monster.buff_attr(ATTR.to_lower(), AMOUNT)

func deactivate():
    .deactivate()
    #GODOT4: use array filter
    for monster in dungeon.monsters:
        if monster.TYPE == MTYPE:
            monster.debuff_attr(ATTR.to_lower(), AMOUNT)

# signals callbacks
func on_new_summon(_summon):
    if _summon.TYPE == MTYPE:
        _summon.buff_attr(ATTR.to_lower(), AMOUNT)
