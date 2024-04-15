extends "continuous_ability.gd"

# variables
var max_move

func _init(ability_dict):
    super(ability_dict)
    max_move = ability_dict["MAX"]

# public functions
func activate():
    summon.max_move_behavior.add_limit(max_move)

func deactivate():
    summon.max_move_behavior.remove_limit(max_move)
