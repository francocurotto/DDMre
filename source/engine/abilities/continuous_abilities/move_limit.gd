extends "continuous_ability.gd"

# variables
var MAX

func _init(ability_dict).(ability_dict):
    MAX = ability_dict["MAX"]

# public functions
func on_dimension():
    monster.max_move_behavior.add_limit(MAX)

func disable():
    .disable()
    monster.max_move_behavior.remove_limit(MAX)
