extends "res://engine/abilities/dim_auto_ability.gd"

func _init(ability_dict):
    super(ability_dict)
    pass

# public functions
func activate():
    dungeon.move_cost = 2
    summon.destroy()
