extends "res://engine/abilities/continuous_ability.gd"

# variables
var MONSTER_TYPE
var ATTR
var AMOUNT

func _init(ability_dict).(ability_dict):
    MONSTER_TYPE = ability_dict["TYPE"]
    ATTR = ability_dict["ATTR"]
    AMOUNT = ability_dict["AMOUNT"]

# public functions
func on_dimension():
    for dungeon_monster in dungeon.monsters:
        if dungeon_monster.TYPE == MONSTER_TYPE:
            dungeon_monster.buff_attr(ATTR.to_lower(), AMOUNT)

func on_new_summon(summon):
    if summon.TYPE == MONSTER_TYPE:
        summon.buff_attr(ATTR.to_lower(), AMOUNT)

func disable():
    .disable()
    for dungeon_monster in dungeon.monsters:
        if dungeon_monster.TYPE == MONSTER_TYPE:
            dungeon_monster.debuff_attr(ATTR.to_lower(), AMOUNT)
