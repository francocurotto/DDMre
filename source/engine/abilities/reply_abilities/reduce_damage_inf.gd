extends "reply_ability.gd"

# variables
var crest = "DEFENSE"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate(_attacker, activate_dict):
    """
    Add temporal reduce to damage behavior.
    """
    var reduce = activate_dict["reduce"]
    monster.player.crestpool.remove_crests(crest, reduce)
    monster.damage_behavior.ability_reduce += 10*reduce

func on_attack_ends():
    monster.damage_behavior.ability_reduce = 0
