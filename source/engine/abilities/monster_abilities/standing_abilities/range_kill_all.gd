extends "res://engine/abilities/standing_ability.gd"

# variables
var tile_range
var cost
var crest

func _init(ability_dict):
    super(ability_dict)
    tile_range = ability_dict["RANGE"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(_activate_dict):
    pay_crests(crest, cost)
    var tiles = get_tiles_in_range(tile_range)
    for tile in tiles:
        if tile != summon.tile and tile.content.is_summon():
            tile.content.destroy()
