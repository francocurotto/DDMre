extends "res://engine/abilities/dimension_item_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_dimension():
    dungeon.move_cost = 2
    item.die()
