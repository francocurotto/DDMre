extends "continuous_ability.gd"
## NEUTRAL ability.
##
## Type advantages and disadvantages does not apply to monster while 
## performing attacks, and being attacked.

#region preloads
const PowerBehaviorNeutral = preload("res://engine/dungobj/behaviors/power_behavior_neutral.gd")
const PowerBehaviorBase = preload("res://engine/dungobj/behaviors/power_behavior_base.gd")
#endregion

#region public functions
## Activate ability. Change monster power behavior to power behavior neutral.
func activate():
    summon.power_behavior = PowerBehaviorNeutral.new(summon)

## Deactivate ability. Switch monster power behavior to power behavior base.
func deactivate():
    summon.target_behavior = PowerBehaviorBase.new(summon)
#endregion
