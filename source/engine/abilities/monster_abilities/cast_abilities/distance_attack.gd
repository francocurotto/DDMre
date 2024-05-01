extends "cast_ability.gd"
## DISTANCEATTACK ability.
##
## For one turn, change attack distance for monster to a higher value (longer 
## range).

#region variables
var max_distance ## Max attack distance for monster attack
var cost         ## Cost to pay to activate abililty
var crest        ## Crest type to pay to activate ability
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    max_distance = ability_dict["MAX"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]
#endregion

#region public functions
## Activate ability. Change attack max distance and connect function for the 
## end of the turn.
func activate(_activate_dict):
    Events.connect("next_turn", Callable(self, "on_next_turn"))
    pay_crests(crest, cost)
    summon.attack_distance = max_distance
    summon.attack_cost = 0
#endregion

#region signals callbacks
## Return to normal attack distance after the end of the turn.
func on_next_turn(_player, _turn):
    Events.disconnect("next_turn", Callable(self, "on_next_turn"))
    summon.attack_distance = 1
    summon.attack_cost = 1
#endregion
