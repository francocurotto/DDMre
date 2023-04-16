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
func activate(activate_dict):
    """
    Range level kill.
    """
    var summon = dungeon.get_tile(activate_dict["pos"]).content
    var total_cost = cost + summon.card.level
    monster.player.crestpool.remove_crests(crest, total_cost)
    summon.die()

func get_select_tiles():
    var opponent_summon_tiles = get_opponent_summons_tiles()
    var range_tiles = []
    for tile in get_tiles_in_range(tile_range):
        if tile in opponent_summon_tiles:
            range_tiles.append(tile)
    return range_tiles
