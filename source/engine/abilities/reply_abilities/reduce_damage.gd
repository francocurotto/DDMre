extends "res://engine/abilities/reply_ability.gd"

# variables
var AMOUNT
var COST
var CREST

func _init(ability_dict).(ability_dict):
    AMOUNT = ability_dict["AMOUNT"]
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(_attacker, _activate_dict):
    """
    Add temporal reduce to damage behavior.
    """
    summon.player.crestpool.remove_crests(CREST, COST)
    summon.damage_behavior.ability_reduce += AMOUNT

func on_attack_ends():
    summon.damage_behavior.ability_reduce = 0
