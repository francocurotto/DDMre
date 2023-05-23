extends "continuous_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_dimension():
    monster.max_move_behavior.add_limit(0)

func disable():
    .disable()
    monster.max_move_behavior.remove_limit(0)
