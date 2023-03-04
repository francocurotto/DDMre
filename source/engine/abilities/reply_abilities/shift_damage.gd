extends "res://engine/abilities/reply_ability.gd"

# variables
var cost
var crest

func _init(ability_dict).(ability_dict):
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(_attacker, activate_dict):
    """
    Add temporal limit to damage behavior.
    """
    monster.player.crestpool.remove_crests(crest, cost)
    #monster.damage_behavior.change_target(activate_dict["pos"])

func on_attack_ends():
    pass
    #monster.damage_behavior.reset_target()
