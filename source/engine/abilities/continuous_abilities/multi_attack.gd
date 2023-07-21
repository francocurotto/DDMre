extends "res://engine/abilities/continuous_ability.gd"

var MAX

func _init(ability_dict).(ability_dict):
    MAX = ability_dict["MAX"]

# public functions
func activate():
    summon.attack_cooldown_behavior.max_attacks = MAX

func deactivate():
    summon.attack_cooldown_behavior.max_attacks = 1
