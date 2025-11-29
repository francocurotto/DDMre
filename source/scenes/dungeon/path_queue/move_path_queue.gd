extends "path_queue.gd"
## Path queue to determine movement paths.

#region is functions 
## Return true if [param path] for a movement can be extended one tile longer.
# is functions 
func is_path_extendable(path):
	var max_length = dungeon.get_max_move_tiles(monster) + 1
	return len(path)<max_length and path[-1].is_passable_by(monster)

## Return true if [param tile] can be used to extend a movement path.
func is_extend_tile(tile):
	return tile.is_reachable() or tile.is_passable_by(monster)
#endregion
