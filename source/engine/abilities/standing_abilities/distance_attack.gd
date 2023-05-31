extends "standing_ability.gd"

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
    monster.player.crestpool.remove_crests(CREST, COST)
    monster.attack_distance = MAX
    monster.attack_cost = 0
    Events.connect("next_turn", self, "on_next_turn")

# signals callbacks
func on_next_turn(_player, _turn):
    monster.attack_distance = 1
    monster.attack_cost = 1
    Events.disconnect("next_turn", self, "on_next_turn")
