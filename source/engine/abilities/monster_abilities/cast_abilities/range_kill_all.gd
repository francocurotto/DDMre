extends "cast_ability.gd"
## RANGEKILLALL ability.
##
## Kill all summons in a range from monster, except for the casting monster.

#region variables
var tile_range ## Range in number of tiles where the summons are destroyed
var cost       ## Cost to pay to activate abililty
var crest      ## Crest type to pay to activate ability
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    tile_range = ability_dict["RANGE"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]
#endregion

#region public functions
## Activate ability. Destroy all summons in range.
func activate(_activate_dict):
    pay_crests(crest, cost)
    var tiles = get_tiles_in_range(tile_range)
    for tile in tiles:
        if tile != summon.tile and tile.content.is_summon():
            tile.content.destroy()
#endregion
