extends "dim_auto_ability.gd"
## DIMADDCREST ability.
##
## Add a specific amount of crests of certain type to player crestpool during
## dimension.

#region variables
var crest  ## Crest type to be added
var amount ## Amount of crests to be added
#endregion

#region
func _init(ability_dict):
    super(ability_dict)
    crest = ability_dict["CREST"]
    amount = ability_dict["AMOUNT"]
#endregion

#region public functions
## Activate ability, add crests to player.
func activate():
    gain_crests(crest, amount)
#endregion
