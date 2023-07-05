extends "path_queue.gd"

func _init(_dungeon, _monster).(_dungeon, monster):
    pass

# is functions 
func is_path_extendable(path):
    var max_length = monster.attack_distance
    return len(path) < max_length and path[-1].is_path()

func is_extend_tile(tile):
    return tile.is_path()
