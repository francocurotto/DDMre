extends "res://engine/abilities/linger_ability.gd"

# constants
const TYPE = "ATTACK"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate(_activate_dict):
    summon.connect("attack_ends", self, "deactivate")

func deactivate():
    summon.disconnect("attack_ends", self, "deactivate")
