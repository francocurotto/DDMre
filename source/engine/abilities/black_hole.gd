extends "base_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate(_monster, dungeon):
    for summon in dungeon.summons:
            summon.die()
