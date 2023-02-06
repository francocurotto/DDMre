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
func on_summon(_monster, dungeon):
    for monster in dungeon.monsters:
        if monster.NAME == type:
            monster.buff_attr(attr.to_lower(), amount)
    Events.connect("card_summoned", self, "on_new_summon")

func on_new_summon(summon):
    if summon.NAME == type:
        summon.buff_attr(attr.to_lower(), amount)

func negate(summon, dungeon):
    .negate(summon, dungeon)
    for monster in dungeon.monsters:
        if monster.NAME == type:
            monster.debuff_attr(attr.to_lower(), amount)
    Events.disconnect("card_summoned", self, "on_new_summon")
