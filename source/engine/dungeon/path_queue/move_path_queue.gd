extends "path_queue.gd"

func _init(_dungeon, _monster).(_dungeon, _monster):
    pass

# is functions 
func is_path_extendable(path):
    var max_length = dungeon.get_max_move_tiles(monster)
    var is_passable = path[-1].is_passable(monster) or path[-1]==monster.tile
    return len(path) < max_length and is_passable

func is_extend_tile(tile):
    return tile.is_reachable() or tile.is_passable()
