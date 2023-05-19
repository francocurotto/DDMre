extends "dimension_ability.gd"

var max_attack

func _init(ability_dict).(ability_dict):
    max_attack = ability_dict["MAX"]

# public functions
func on_dimension():
    monster.attack_cooldown_behavior.max_attacks = max_attack

func disable():
    monster.attack_cooldown_behavior.max_attacks = 1
