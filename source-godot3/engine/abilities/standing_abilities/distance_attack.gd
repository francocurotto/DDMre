extends "res://engine/abilities/standing_ability.gd"

# variables
var max_distance
var cost
var crest

func _init(ability_dict).(ability_dict):
    max_distance = ability_dict["MAX"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(_activate_dict):
    """
    Buff monster attr by damage.
    """
    Events.connect("next_turn", self, "on_next_turn")
    pay_crests(crest, cost)
    summon.attack_distance = max_distance
    summon.attack_cost = 0

# signals callbacks
func on_next_turn(_player, _turn):
    Events.disconnect("next_turn", self, "on_next_turn")
    summon.attack_distance = 1
    summon.attack_cost = 1
