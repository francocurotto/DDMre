extends "standing_ability.gd"

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
    monster.player.crestpool.remove_crests(CREST, total_cost)
    var roll_tiles = get_roll_tiles(activate_dict["direction"])
    
    # roll loop
    var last_unoccupied = monster.tile
    for tile in roll_tiles:
        var summon = tile.content
        if not tile.is_occupied():
            last_unoccupied = tile
        elif not is_passable(summon) and summon.card.level<=level:
            summon.die()
            last_unoccupied = tile
        elif not is_passable(summon) and summon.card.level>level:
            break
    last_unoccupied.move_content_from(monster.tile)

func get_roll_tiles(direction):
    var pos = monster.tile.pos + direction
    var tiles = []
    while dungeon.pos_within_dungeon(pos):
        var tile = dungeon.get_tile(pos)
        if tile.is_empty() or tile.content.is_monster_lord():
            break
        tiles.append(dungeon.get_tile(pos))
        pos = pos + direction
    return tiles

# private functions
func is_passable(summon):
    return summon.is_monster() and summon.is_flying()
