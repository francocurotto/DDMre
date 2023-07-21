extends "res://engine/abilities/standing_ability.gd"

# variables
var COST
var CREST

func _init(ability_dict).(ability_dict):
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    """
    Roll level kill.
    """
    var level = activate_dict["level"]
    var total_cost = COST + level
    summon.player.crestpool.remove_crests(CREST, total_cost)
    var roll_tiles = get_roll_tiles(activate_dict["direction"])
    
    # roll loop
    var last_empty = summon.tile
    for tile in roll_tiles:
        var roll_summon = tile.content
        if not tile.is_empty():
            last_empty = tile
        elif not is_passable(roll_summon) and roll_summon.card.level<=level:
            roll_summon.destroy()
            last_empty = tile
        elif not is_passable(roll_summon) and roll_summon.card.level>level:
            break
    last_empty.move_content_from(summon.tile)

func get_roll_tiles(direction):
    var pos = summon.tile.pos + direction
    var tiles = []
    while dungeon.pos_within_dungeon(pos):
        var tile = dungeon.get_tile(pos)
        if tile.is_open() or tile.content.is_monster_lord():
            break
        tiles.append(dungeon.get_tile(pos))
        pos = pos + direction
    return tiles

# private functions
func is_passable(roll_summon):
    return roll_summon.has_active_ability("FLY")
