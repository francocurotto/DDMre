extends "dim_manual_ability.gd"
## DIMTRADECREST ability.
##
## Pay a certain number of crests of any type to gain a different amount of 
## other type.

#region variables
var cost   ## Number of crests to pay in trade
var amount ## Number of crests to gain in trade
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    amount = ability_dict["AMOUNT"]
#endregion

#region public functions
## Activate ability using parameters [param activate_dict]. Trade crests.
func activate(activate_dict):
    pay_crests(activate_dict["pay_crest"], cost)
    gain_crests(activate_dict["gain_crest"], amount)
#endregion
