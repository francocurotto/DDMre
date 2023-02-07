extends "base_ability.gd"

# variables
var type
var attr
var amount

func _init(ability_dict).(ability_dict):
    type = ability_dict["TYPE"]
    attr = ability_dict["ATTR"]
    amount = ability_dict["AMOUNT"]

# public functions
func summon_activate():
    for monster in dungeon.monsters:
        if monster.NAME == type:
            monster.buff_attr(attr.to_lower(), amount)

func on_new_summon(new_summon):
    if new_summon.NAME == type:
        new_summon.buff_attr(attr.to_lower(), amount)

func deactivate():
    for monster in dungeon.monsters:
        if monster.NAME == type:
            monster.debuff_attr(attr.to_lower(), amount)
