extends "res://engine/abilities/dim_auto_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate():
    summon.tile.vortex = true
    summon.destroy()

