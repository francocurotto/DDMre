extends "cast_ability.gd"
## KILLBLOCK ability.
##
## Remove a block tile from dungeon and replace it with open tile.

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
## Activate ability using parameters [param activate_dict]. Destroy block tile.
func activate(activate_dict):
    pay_crests(crest, cost)
    var pos = activate_dict["pos"]
    dungeon.place_open_tile(pos)

## Get tiles where ability can be casted.
func get_select_tiles():
    return get_block_tiles()
#endregion
