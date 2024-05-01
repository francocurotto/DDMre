extends "reply_ability.gd"
## REDUCEDAMAGEINF ability.
##
## Reduce damage inflicted by attack by an amount defined during ability 
## activation.

#region public functions
## Activate ability. Add temporal reduction to damage behavior. The amount of
## damage to reduce is defined on [param activate_dict]. Pay the equivalent 
## amount in DEFENSE crests.
func activate(_attacker, activate_dict):
    super(_attacker, activate_dict)
    var reduce = activate_dict["reduce"]
    pay_crests("DEFENSE", reduce)
    summon.damage_behavior.ability_reduce += 10*reduce

## Deactivate ability. Remove temporal reduction to damage behavior.
func deactivate():
    super()
    summon.damage_behavior.ability_reduce = 0
#endregion
