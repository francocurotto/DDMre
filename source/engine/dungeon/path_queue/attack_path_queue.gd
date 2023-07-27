extends "path_queue.gd"

func _init(_dungeon, _monster):
    super(_dungeon, _monster)
    pass

# is functions 
func is_path_extendable(path):
    var max_length = monster.attack_distance + 1
    return len(path) < max_length and path[-1].is_path()

func is_extend_tile(tile):
    return tile.is_path()
