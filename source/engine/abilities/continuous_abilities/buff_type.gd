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
func on_dimension():
    for dungeon_monster in dungeon.monsters:
        if dungeon_monster.NAME == type:
            dungeon_monster.buff_attr(attr.to_lower(), amount)

func on_new_summon(summon):
    if summon.NAME == type:
        summon.buff_attr(attr.to_lower(), amount)

func disable():
    .disable()
    for dungeon_monster in dungeon.monsters:
        if dungeon_monster.NAME == type:
            dungeon_monster.debuff_attr(attr.to_lower(), amount)
