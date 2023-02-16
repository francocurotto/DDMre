extends "res://engine/abilities2/dimension_ability.gd"

# variables
var limit

func _init(ability_dict).(ability_dict):
    limit = ability_dict["LIMIT"]

# public functions
func on_dimension():
    monster.max_move_behavior.add_limit(limit)
