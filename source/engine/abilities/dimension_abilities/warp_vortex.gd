extends "res://engine/abilities/dim_auto_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_dimension():
    summon.tile.vortex = true
    summon.destroy()

