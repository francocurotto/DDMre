extends "reply_ability.gd"
## REDUCEDAMAGE ability.
##
## Reduce damage inflicted by attack by a certain amount.

#region variables
var amount ## Amount to reduce the inflicted damage
var cost   ## Cost to pay to activate abililty
var crest  ## Crest type to pay to activate ability
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    amount = ability_dict["AMOUNT"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]
#endregion

#region public functions
## Activate ability. Add temporal reduction to damage behavior.
func activate(_attacker, _activate_dict):
    super(_attacker, _activate_dict)
    pay_crests(crest, cost)
    summon.damage_behavior.ability_reduce += amount

## Deactivate ability. Remove temporal reduction to damage behavior.
func deactivate():
    super()
    summon.damage_behavior.ability_reduce = 0
#endregion
