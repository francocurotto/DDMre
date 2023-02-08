extends "base_ability.gd"

# variables
var type

func _init(ability_dict).(ability_dict):
    type = ability_dict["TYPE"]

# public functions
func summon_activate():
    for monster in dungeon.monsters:
        if monster.NAME == type:
            monster.damage_behavior.add_limit(0)

func on_new_summon(new_summon):
    if new_summon.NAME == type:
        new_summon.damage_behavior.add_limit(0)

func deactivate():
    for monster in dungeon.monsters:
        if monster.NAME == type:
            monster.damage_behavior.remove_limit(0)
