extends "reply_ability.gd"

# variables
var COST
var CREST

func _init(ability_dict).(ability_dict):
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(_attacker, _activate_dict):
    """
    Add temporal limit to damage behavior.
    """
    monster.player.crestpool.remove_crests(CREST, COST)
    monster.damage_behavior.add_limit(0)

func on_attack_ends():
    monster.damage_behavior.remove_limit(0)
