extends "continuous_ability.gd"
## MOVELIMIT ability.
##
## Add a limit of tiles a monster can move per turn.

#region variables
var max_move ## Max number of tiles of movement per turn the ability allows
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    max_move = ability_dict["MAX"]
#endregion

#region public functions
## Activate ability. Add limit to move behavior.
func activate():
    summon.max_move_behavior.add_limit(max_move)

## Deactivate ability. Remove limit in move behavior.
func deactivate():
    summon.max_move_behavior.remove_limit(max_move)
#endregion
