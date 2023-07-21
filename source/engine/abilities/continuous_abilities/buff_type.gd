extends "res://engine/abilities/continuous_ability.gd"

# variables
var type
var attr
var amount

func _init(ability_dict).(ability_dict):
    type = ability_dict["TYPE"]
    attr = ability_dict["ATTR"]
    amount = ability_dict["AMOUNT"]

# public functions
func activate():
    .activate()
    #GODOT4: use array filter
    for monster in dungeon.monsters:
        if monster.TYPE == type:
            monster.buff_attr(attr, amount)

func deactivate():
    .deactivate()
    #GODOT4: use array filter
    for monster in dungeon.monsters:
        if monster.TYPE == type:
            monster.debuff_attr(attr, amount)

# signals callbacks
func on_new_summon(_summon):
    if _summon.TYPE == type:
        _summon.buff_attr(attr, amount)
