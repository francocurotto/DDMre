extends "res://engine/abilities/dimension_item_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_dimension():
    item.tile.vortex = true
    item.die()

