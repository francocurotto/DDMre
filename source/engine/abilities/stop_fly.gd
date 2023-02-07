extends "base_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func summon_activate():
    for monster in dungeon.monsters:
        for ability in monster.card.abilities:
            if ability.name == "FLY":
                ability.negate()

func on_new_summon(new_summon):
    for ability in new_summon.card.abilities:
        if ability.name == "FLY":
            ability.negate()

func deactivate():
    for monster in dungeon.monsters:
        for ability in monster.card.abilities:
            if ability.name == "FLY":
                ability.remove_negate()
