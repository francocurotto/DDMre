extends "base_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_summon(item, dungeon):
    dungeon.move_cost = 2
    item.die()

func activate(_monster, _dungeon):
    pass
