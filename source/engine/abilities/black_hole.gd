extends "base_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func item_activate(_monster):
    for dungeon_summon in dungeon.summons:
            dungeon_summon.die()
