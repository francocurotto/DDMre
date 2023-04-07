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
    var tiles = get_tiles_in_range()
    for tile in tiles:
        if tile.is_path() and tile.content.is_summon():
            tile.content.die()

func get_tiles_in_range():
    """
    Return a list of tiles at range tile_range from ability monster position
    (excluding monster own position).
    """
    var init_pos = monster.tile.pos
    var range_tiles = []
    for tile in dungeon.tiles:
        var range_dist = abs(tile.pos.x-init_pos.x) + abs(tile.pos.y-init_pos.y)
        if range_dist>0 and  range_dist<=tile_range:
            if tile.is_path():
                range_tiles.append(tile)
    return range_tiles
    
