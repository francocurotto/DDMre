extends "ability.gd"

# variables
var negate_count = 0

func _init(ability_dict).(ability_dict):
    pass

# public functions
func negate():
    negate_count += 1

func remove_negate():
    negate_count -= 1

# is functions
func is_negated():
    return negate_count > 0
