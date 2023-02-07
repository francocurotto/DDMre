extends "base_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func summon_activate():
    summon.turn_move_limit = 0
