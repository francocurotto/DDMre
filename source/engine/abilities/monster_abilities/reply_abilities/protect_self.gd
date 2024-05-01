extends "reply_ability.gd"
## PROTECTSELF ability.
##
## Reduce damage inflicted by attack to zero (damage is avoided).

#region variables
var cost  ## Cost to pay to activate abililty
var crest ## Crest type to pay to activate ability
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]
#endregion

#region public functions
## Activate ability. Add temporal limit to damage behavior.
func activate(_attacker, _activate_dict):
    super(_attacker, _activate_dict)
    pay_crests(crest, cost)
    summon.damage_behavior.add_limit(0)

## Deactivate ability. Remove temporal limit to damage behavior.
func deactivate():
    super()
    summon.damage_behavior.remove_limit(0)
#endregion
