extends "standing_ability.gd"

# variables
var dist
var cost
var crest

func _init(ability_dict).(ability_dict):
    dist = ability_dict["MAX"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(_activate_dict):
    """
    Buff monster attr by damage.
    """
    monster.player.crestpool.remove_crests(crest, cost)
    monster.attack_distance = dist
    monster.attack_cost = 0
    Events.connect("next_turn", self, "on_next_turn")

# signals callbacks
func on_next_turn(_player, _turn):
    monster.attack_distance = 1
    monster.attack_cost = 1
    Events.disconnect("next_turn", self, "on_next_turn")
