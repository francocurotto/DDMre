extends "standing_ability.gd"

# variables
var tile_range
var cost
var crest

func _init(ability_dict).(ability_dict):
    tile_range = ability_dict["RANGE"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(_activate_dict):
    """
    Destroy everything in range.
    """
    monster.player.crestpool.remove_crests(crest, cost)
    var tiles = get_tiles_in_range(tile_range)
    for tile in tiles:
        if tile.is_path() and tile.content.is_summon():
            tile.content.die()
