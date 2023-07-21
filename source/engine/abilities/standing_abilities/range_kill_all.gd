extends "res://engine/abilities/standing_ability.gd"

# variables
var RANGE
var COST
var CREST

func _init(ability_dict).(ability_dict):
    RANGE = ability_dict["RANGE"]
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(_activate_dict):
    """
    Destroy everything in range.
    """
    pay_crests(CREST, COST)
    var tiles = get_tiles_in_range(RANGE)
    for tile in tiles:
        if tile.is_path() and tile.content.is_summon():
            tile.content.destroy()
