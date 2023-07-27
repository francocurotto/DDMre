extends "res://engine/abilities/reply_ability.gd"

# variables
var cost
var crest

func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(attacker, _activate_dict):
    """
    Permanently add foe defense to monster defense.
    """
    pay_crests(crest, cost)
    summon.defense += attacker.defense
