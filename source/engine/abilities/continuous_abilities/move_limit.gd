extends "res://engine/abilities/continuous_ability.gd"

# variables
var MAX

func _init(ability_dict).(ability_dict):
    MAX = ability_dict["MAX"]

# public functions
func activate():
    summon.max_move_behavior.add_limit(MAX)

func deactivate():
    summon.max_move_behavior.remove_limit(MAX)
