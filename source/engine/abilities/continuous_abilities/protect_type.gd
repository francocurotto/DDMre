extends "res://engine/abilities/continuous_ability.gd"

# variables
var MONSTER_TYPE

func _init(ability_dict).(ability_dict):
    MONSTER_TYPE = ability_dict["TYPE"]

# public functions
func on_dimension():
    for dungeon_monster in dungeon.monsters:
        if dungeon_monster.TYPE == MONSTER_TYPE:
            dungeon_monster.damage_behavior.add_limit(0)

func on_new_summon(summon):
    if summon.TYPE == MONSTER_TYPE:
        summon.damage_behavior.add_limit(0)

func disable():
    .disable()
    for dungeon_monster in dungeon.monsters:
        if dungeon_monster.TYPE == MONSTER_TYPE:
            dungeon_monster.damage_behavior.remove_limit(0)
