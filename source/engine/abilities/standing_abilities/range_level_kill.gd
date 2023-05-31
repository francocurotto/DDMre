extends "standing_ability.gd"

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
    var summon = dungeon.get_tile(activate_dict["pos"]).content
    var total_cost = COST + summon.card.level
    monster.player.crestpool.remove_crests(CREST, total_cost)
    summon.die()

func get_select_tiles():
    var opponent_summon_tiles = get_opponent_summons_tiles()
    var range_tiles = []
    for tile in get_tiles_in_range(RANGE):
        if tile in opponent_summon_tiles:
            range_tiles.append(tile)
    return range_tiles
