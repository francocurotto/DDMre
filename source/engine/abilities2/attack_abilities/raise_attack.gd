extends "res://engine/abilities2/attack_ability.gd"

# variables
var max_raise

func _init(ability_dict).(ability_dict):
    max_raise = ability_dict["MAX"]

# public functions
func activate(ability_dict):
    """
    Add temporal buff to power behavior.
    """
    var raise = ability_dict["raise"]
    monster.player.crestpool.remove_crests("ATTACK", raise)
    monster.power_behavior.ability_buff += 10*raise

func on_attack_ends():
    monster.power_behavior.ability_buff = 0
