extends "reply_ability.gd"

# variables
var COST
var CREST

func _init(ability_dict).(ability_dict):
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(attacker, _activate_dict):
    """
    Permanently add foe defense to monster defense.
    """
    monster.player.crestpool.remove_crests(CREST, COST)
    monster.defense += attacker.defense

func on_attack_ends():
    pass
