extends "dim_manual_ability.gd"
## DIMCURE ability.
##
## Cure a number of player monsters a certain amount of health points, by
## paying a specific amount of crests.

#region variables
var amount ## Amount of heal points to cure
var number ## Number of monsters to cure
var cost   ## Amount of crest to pay as cost
var crest  ## Crest type to pay as cost
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    amount = ability_dict["AMOUNT"]
    number = ability_dict["NUMBER"]
    cost   = ability_dict["COST"]
    crest  = ability_dict["CREST"]
#endregion

#region public functions
## Activate ability using parameters [param activate_dict]. Cure monsters and
## pay ability cost.
func activate(activate_dict):
    pay_crests(crest, cost)
    for pos in activate_dict["positions"]:
        var monster = dungeon.get_tile(pos).content
        monster.restore_health(amount)

## Get tiles where ability can be casted.
func get_select_tiles():
    return get_player_other_monsters_tiles()
#endregion
