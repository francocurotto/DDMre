extends "cast_ability.gd"
## BUFFSELF ability.
##
## Buff monster attribute in a certain amount.

#region variables
var attr   ## Monster attribute to buff
var amount ## Amount to buff monster attribute
var cost   ## Cost to pay to activate abililty
var crest  ## Crest type to pay to activate ability
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    attr = ability_dict["ATTR"]
    amount = ability_dict["AMOUNT"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]
#endregion

#region public functions
## Activate ability. Buff monster attribute by certain amount.
func activate(_activate_dict):
    pay_crests(crest, cost)
    summon.buff_attr(attr, amount)
#endregion
