extends "res://engine/abilities/attack_ability.gd"

# variables
var MAX

func _init(ability_dict).(ability_dict):
    MAX = ability_dict["MAX"]

# public functions
func activate(activate_dict):
    """
    Add temporal buff to power behavior.
    """
    var raise = activate_dict["raise"]
    summon.player.crestpool.remove_crests("ATTACK", raise)
    summon.power_behavior.ability_buff += 10*raise

func on_attack_ends():
    summon.power_behavior.ability_buff = 0
