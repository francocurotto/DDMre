extends "res://engine/abilities/continuous_ability.gd"

var max_attack

func _init(ability_dict).(ability_dict):
    max_attack = ability_dict["MAX"]

# public functions
func activate():
    summon.attack_cooldown_behavior.max_attacks = max_attack

func deactivate():
    summon.attack_cooldown_behavior.max_attacks = 1
