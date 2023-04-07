extends "reply_ability.gd"

# variables
var cost
var crest
var amount

func _init(ability_dict).(ability_dict):
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]
    amount = ability_dict["AMOUNT"]

# public functions
func activate(_attacker, _activate_dict):
    """
    Add temporal reduce to damage behavior.
    """
    monster.player.crestpool.remove_crests(crest, cost)
    monster.damage_behavior.ability_reduce += amount

func on_attack_ends():
    monster.damage_behavior.ability_reduce = 0
