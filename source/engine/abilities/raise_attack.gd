extends "base_ability.gd"

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
    summon.player.crestpool.remove_crests("ATTACK", raise)
    summon.power_behavior.ability_buff += 10*raise

func on_monster_attack_finished():
    summon.power_behavior.ability_buff = 0
