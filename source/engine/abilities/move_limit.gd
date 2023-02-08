extends "base_ability.gd"

# variables
var limit

func _init(ability_dict).(ability_dict):
    limit = ability_dict["LIMIT"]

# public functions
func summon_activate():
    summon.max_move_behavior.add_limit(limit)
