extends "continuous_ability.gd"
## TUNNEL ability.
##
## Monster can pass thorough other monsters during movement.

#region preloads
const PassBehaviorBase = preload("res://engine/dungobj/behaviors/pass_behavior_base.gd")
const PassBehaviorTunnel = preload("res://engine/dungobj/behaviors/pass_behavior_tunnel.gd")
#endregion

#region public functions
## Activate ability. Change monster pass behavior to pass behavior tunnel.
func activate():
    summon.pass_behavior = PassBehaviorTunnel.new()

## Deactivate ability. Switch monster pass behavior to pass behavior base.
func deactivate():
    summon.pass_behavior = PassBehaviorBase.new()
#endregion
