extends "res://engine/abilities2/manual_item_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate(_monster):
    for summon in dungeon.summons:
            summon.die()
