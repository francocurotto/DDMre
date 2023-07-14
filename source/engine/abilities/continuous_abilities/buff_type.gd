extends "continuous_ability.gd"

# variables
var TYPE
var ATTR
var AMOUNT

func _init(ability_dict).(ability_dict):
    TYPE = ability_dict["TYPE"]
    ATTR = ability_dict["ATTR"]
    AMOUNT = ability_dict["AMOUNT"]

# public functions
func on_dimension():
    for dungeon_monster in dungeon.monsters:
        if dungeon_monster.TYPE == TYPE:
            dungeon_monster.buff_attr(ATTR.to_lower(), AMOUNT)

func on_new_summon(summon):
    if summon.TYPE == TYPE:
        summon.buff_attr(ATTR.to_lower(), AMOUNT)

func disable():
    .disable()
    for dungeon_monster in dungeon.monsters:
        if dungeon_monster.TYPE == TYPE:
            dungeon_monster.debuff_attr(ATTR.to_lower(), AMOUNT)
