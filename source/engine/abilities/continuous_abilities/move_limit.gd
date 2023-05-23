extends "continuous_ability.gd"

# variables
var limit

func _init(ability_dict).(ability_dict):
    limit = ability_dict["LIMIT"]

# public functions
func on_dimension():
    monster.max_move_behavior.add_limit(limit)

func disable():
    .disable()
    monster.max_move_behavior.remove_limit(limit)
