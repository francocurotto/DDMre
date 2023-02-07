extends "base_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_summon(_monster, dungeon):
    for monster in dungeon.monsters:
        for ability in monster.card.abilities:
            if ability.name == "TUNNEL":
                ability.negate()
    Events.connect("card_summoned", self, "on_new_summon")

#func on_new_summon(summon):
#    if summon.NAME == type:
#        summon.buff_attr(attr.to_lower(), amount)

#func negate(summon, dungeon):
#    .negate(summon, dungeon)
#    for monster in dungeon.monsters:
#        if monster.NAME == type:
#            monster.debuff_attr(attr.to_lower(), amount)
#    Events.disconnect("card_summoned", self, "on_new_summon")
