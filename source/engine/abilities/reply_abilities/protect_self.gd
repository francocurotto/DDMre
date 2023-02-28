extends "res://engine/abilities/reply_ability.gd"

# variables
var cost
var crest

func _init(ability_dict).(ability_dict):
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(_attacker, _activate_dict):
    """
    Add temporal limit to damage behavior.
    """
    monster.player.crestpool.remove_crests(crest, cost)
    monster.damage_behavior.add_limit(0)

func on_attack_ends():
    monster.damage_behavior.remove_limit(0)
