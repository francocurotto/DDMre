extends "path_queue.gd"

func _init(_dungeon, _monster):
    super(_dungeon, _monster)
    pass

# is functions 
func is_path_extendable(path):
    var max_length = dungeon.get_max_move_tiles(monster) + 1
    return len(path)<max_length and path[-1].is_passable_by(monster)

func is_extend_tile(tile):
    return tile.is_reachable() or tile.is_passable_by(monster)
