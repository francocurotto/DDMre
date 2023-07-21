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
func activate(activate_dict):
    """
    Range level kill.
    """
    var kill_summon = dungeon.get_tile(activate_dict["pos"]).content
    var total_cost = COST + kill_summon.card.level
    pay_crests(CREST, total_cost)
    kill_summon.destroy()

func get_select_tiles():
    var opponent_summon_tiles = get_opponent_summons_tiles()
    var range_tiles = []
    for tile in get_tiles_in_range(RANGE):
        if tile in opponent_summon_tiles:
            range_tiles.append(tile)
    return range_tiles
