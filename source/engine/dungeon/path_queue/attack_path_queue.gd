extends "path_queue.gd"

#TODO: check and delete
#func _init(_dungeon, _monster):
#    super(_dungeon, _monster)
#    pass

#region is functions 
## Return true if [param path] for an attack can be extended one tile longer.
func is_path_extendable(path):
    var max_length = monster.attack_distance + 1
    return len(path) < max_length and path[-1].is_path()

## Return true if [param tile] can be used to extend an atrack path.
func is_extend_tile(tile):
    return tile.is_path()
##endregion
