extends "res://engine/abilities/reply_ability.gd"

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
    summon.player.crestpool.remove_crests(CREST, COST)
    summon.defense += attacker.defense
