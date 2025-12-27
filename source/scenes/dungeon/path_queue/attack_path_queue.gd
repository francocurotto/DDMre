extends "path_queue.gd"
## Path queue to determine attack paths.

#region is functions 
## Return true if [param path] for an attack can be extended one tile longer.
func is_path_extendable(path):
	var max_length = monster.attack_distance + 1
	return len(path) < max_length and path[-1].has_path()

## Return true if [param tile] can be used to extend an atrack path.
func is_extend_tile(tile):
	return tile.has_path()
##endregion
