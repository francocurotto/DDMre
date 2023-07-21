extends "res://engine/abilities/continuous_ability.gd"

# variables
var MTYPE

func _init(ability_dict).(ability_dict):
    MTYPE = ability_dict["MTYPE"]

# public functions
func activate():
    .activate()
    for monster in dungeon.monsters:
        if monster.TYPE == MTYPE:
            monster.damage_behavior.add_limit(0)

func deactivate():
    .deactivate()
    for monster in dungeon.monsters:
        if monster.TYPE == MTYPE:
            monster.damage_behavior.remove_limit(0)

# signals callbacks
func on_new_summon(_summon):
    if _summon.TYPE == MTYPE:
        _summon.damage_behavior.add_limit(0)
