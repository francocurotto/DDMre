extends "res://engine/abilities/continuous_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate():
    summon.max_move_behavior.add_limit(0)

func deactivate():
    summon.max_move_behavior.remove_limit(0)
