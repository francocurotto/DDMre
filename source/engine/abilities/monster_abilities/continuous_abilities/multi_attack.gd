extends "continuous_ability.gd"
## MULTIATTACK ability.
##
## Allow monster to perform multiple attacks per turn.

#region variables
var max_attack ## MAx number of attacks per turn the ability allows.
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    max_attack = ability_dict["MAX"]
#endregion

#region public functions
## Activate ability. Change the max attack value in attack cooldown behavior.
func activate():
    summon.attack_cooldown_behavior.max_attacks = max_attack

## Deactivate ability. Set the max attack value in attack cooldown behavior 
## to 1.
func deactivate():
    summon.attack_cooldown_behavior.max_attacks = 1
#endregion
