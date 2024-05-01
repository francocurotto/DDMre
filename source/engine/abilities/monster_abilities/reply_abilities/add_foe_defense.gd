extends "reply_ability.gd"
## ADDFOEDEFENSE ability.
##
## Permanently add attacker defense value to own defense value.

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
## Activate ability. Permanently add [param attacker] defense to monster
## defense.
func activate(attacker, _activate_dict):
    pay_crests(crest, cost)
    summon.defense += attacker.defense
#endregion
