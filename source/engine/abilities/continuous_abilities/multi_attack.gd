extends "continuous_ability.gd"

var MAX

func _init(ability_dict).(ability_dict):
    MAX = ability_dict["MAX"]

# public functions
func on_dimension():
    monster.attack_cooldown_behavior.max_attacks = MAX

func disable():
    .disable()
    monster.attack_cooldown_behavior.max_attacks = 1