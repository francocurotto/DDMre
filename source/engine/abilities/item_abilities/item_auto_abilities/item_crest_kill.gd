extends "item_auto_ability.gd"
## ITEMCRESTKILL ability.
##
## Reduce in a specific amount the number of crests of certain type, of player 
## owner of monster.

#region variables
var crest  ## Crest type to reduce
var amount ## Amount to reduce in crestpool
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    crest = ability_dict["CREST"]
    amount = ability_dict["AMOUNT"]
#endregion

#region public functions
## Activate ability. Reduce crests of player owner of [param monster].
func activate(monster):
    monster.player.crestpool.remove_crests(crest, amount)
#endregion
