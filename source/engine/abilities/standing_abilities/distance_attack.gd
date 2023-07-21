extends "res://engine/abilities/reply_ability.gd"

# variables
var MAX
var COST
var CREST

func _init(ability_dict).(ability_dict):
    MAX = ability_dict["MAX"]
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(_activate_dict):
    """
    Buff monster attr by damage.
    """
    summon.player.crestpool.remove_crests(CREST, COST)
    summon.attack_distance = MAX
    summon.attack_cost = 0
    Events.connect("next_turn", self, "on_next_turn")

# signals callbacks
func on_next_turn(_player, _turn):
    summon.attack_distance = 1
    summon.attack_cost = 1
    Events.disconnect("next_turn", self, "on_next_turn")
