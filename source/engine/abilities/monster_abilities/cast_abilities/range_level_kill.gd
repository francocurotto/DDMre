extends "cast_ability.gd"
## RANGELEVELKILL ability.
##
## Destroy an opponent summon that is located at a certain range. The casting 
## cost increases with the summon level.

# variables
var tile_range ## Range in number of tiles where the summon can be located
var cost       ## Cost to pay to activate abililty
var crest      ## Crest type to pay to activate ability

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    tile_range = ability_dict["RANGE"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]
#endregion

#region public functions
## Activate ability using parameters [param activate_dict]. Destroy summon 
## located at a certain range.
func activate(activate_dict):
    var pos = activate_dict["pos"]
    var kill_summon = dungeon.get_tile(pos).content
    var total_cost = cost + kill_summon.card.level
    pay_crests(crest, total_cost)
    kill_summon.destroy()

## Get tiles where ability can be casted.
func get_select_tiles():
    return get_range_opponent_summon_tiles(tile_range)
#endregion
