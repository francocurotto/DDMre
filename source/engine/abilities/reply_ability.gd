extends "res://engine/abilities/linger_ability.gd"

# constants
const TYPE = "REPLY"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate(attacker, _activate_dict):
    attacker.connect("attack_ends", self, "deactivate")

func deactivate():
    summon.disconnect("attack_ends", self, "deactivate")
