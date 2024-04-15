extends "res://engine/abilities/standing_ability.gd"

# variables
var cost
var crest

func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    var level = activate_dict["level"]
    var total_cost = cost + level
    pay_crests(crest, total_cost)
    var roll_tiles = get_roll_tiles(activate_dict["direction"])
    
    # roll loop
    var last_empty = summon.tile
    for tile in roll_tiles:
        var roll_summon = tile.content
        if tile.is_empty():
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
    while is_pos_rollable(pos):
        tiles.append(dungeon.get_tile(pos))
        pos = pos + direction
    return tiles

# is functions
func is_pos_rollable(pos):
    if not dungeon.pos_within_dungeon(pos):
        return false
    var tile = dungeon.get_tile(pos)
    return tile.is_path() and not tile.content.is_monster_lord()

func is_passable(roll_summon):
    return roll_summon.has_active_ability("FLY")
