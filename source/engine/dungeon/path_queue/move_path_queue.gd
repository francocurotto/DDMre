extends "path_queue.gd"

# is functions 
func is_path_extendable(path):
    var max_length = dungeon.get_max_move_tiles(monster)
    return len(path) < max_length and path[-1].is_passable()

func is_extend_tile(tile):
    return tile.is_reachable() or tile.is_passable()
