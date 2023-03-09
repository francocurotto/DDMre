extends "continuous_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_dimension():
    for dungeon_monster in dungeon.monsters:
        for ability in dungeon_monster.card.abilities:
            if ability.name == "TUNNEL":
                ability.negate()

func on_new_summon(summon):
    for ability in summon.card.abilities:
        if ability.name == "TUNNEL":
            ability.negate()

func disable():
    .disable()
    for dungeon_monster in dungeon.monsters:
        for ability in dungeon_monster.card.abilities:
            if ability.name == "TUNNEL":
                ability.remove_negate()
