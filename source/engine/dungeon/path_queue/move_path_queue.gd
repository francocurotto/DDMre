extends "path_queue.gd"

func _init(_dungeon, _monster).(_dungeon, _monster):
    pass

# is functions 
func is_path_extendable(path):
    var max_length = dungeon.get_max_move_tiles(monster) + 1
    var is_passable = monster.is_tile_passable(path[-1])
    return len(path) < max_length and is_passable

func is_extend_tile(tile):
    return tile.is_reachable() or monster.is_tile_passable(tile)
