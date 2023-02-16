extends "res://engine/abilities/continuous_ability.gd"

# variables
var type

func _init(ability_dict).(ability_dict):
    type = ability_dict["TYPE"]

# public functions
func on_dimension():
    for dungeon_monster in dungeon.monsters:
        if dungeon_monster.NAME == type:
            dungeon_monster.damage_behavior.add_limit(0)

func on_new_summon(summon):
    if summon.NAME == type:
        summon.damage_behavior.add_limit(0)

func disable():
    .disable()
    for dungeon_monster in dungeon.monsters:
        if dungeon_monster.NAME == type:
            dungeon_monster.damage_behavior.remove_limit(0)
