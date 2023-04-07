extends "reply_ability.gd"

# variables
var cost
var crest

func _init(ability_dict).(ability_dict):
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(attacker, _activate_dict):
    """
    Permanently add foe defense to monster defense.
    """
    monster.player.crestpool.remove_crests(crest, cost)
    monster.defense += attacker.defense

func on_attack_ends():
    pass
