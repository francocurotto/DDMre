extends "continuous_ability.gd"
## FROZEN ability.
##
## Disable monster movement.

#region public functions
## Activate ability. Add zero tiles limit to move behavior.
func activate():
    summon.max_move_behavior.add_limit(0)

## Deactivate ability. Remove zero tiles limit to move behavior.
func deactivate():
    summon.max_move_behavior.remove_limit(0)
#endregion
