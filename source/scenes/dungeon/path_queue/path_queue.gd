extends RefCounted
## Queue object used to compute possible path of tiles from an origin.
##
## The path queue uses a queue structure to compute all possible path of tiles
## from a monster position. It is used to get path for monsters movements and
## attacks.

#region variables
var dungeon ## dungeon where the path is computed
var monster ## monster whose position is used as the start of paths
var paths   ## Array of computed paths
var tiles   ## Array of all tiles that compose all the computed paths
#endregion

#region builtin functions
func _init(_dungeon, _monster):
	dungeon = _dungeon
	monster = _monster
	paths = [[monster.tile.base_tile]]
	tiles = [monster.tile.base_tile]
	fill_paths()
# endregion

#region public functions
## Return a path between all computed paths that has a final tile equals to
## tile [param dest]. If no such path is found, return an empty tile.
func get_path(dest):
	for path in paths:
		if path[-1] == dest:
			return path
	return []
#endregion

#region is functions
## Return true if [param _path] can be extended from its final tile to create
## new path one tile longer. Must be implemented by child classes.
func is_path_extendable(_path):
	pass

## Return true if [param _tile] can be used to extend a path one tile longer.
## Must be implemented by child classes.
func is_extend_tile(_tile):
	pass
#endregion

# private functions
## Using the array "paths" as a queue, compute all the possible paths using 
## breadth-first search algorithm, to ensure getting the shortest paths to 
## each destination tile.
func fill_paths():
	for path in paths:
		for next_tile in get_next_tiles(path):
			if not next_tile in tiles:
				var new_path = path.duplicate()
				new_path.append(next_tile)
				paths.append(new_path)
				tiles.append(next_tile)

## Get all possible adjacent tiles to extend a [param path]. Use 
## "is_path_extendable" to check if path cam be extended, and 
## "is_extended_tile" to check if a tile can be used to extend the path.
func get_next_tiles(path):
	var next_tiles = []
	if is_path_extendable(path):
		var coor = dungeon.get_tilecoor(path[-1])
		for tile in dungeon.get_neighbor_tiles(coor):
			if tile != path[-1] and is_extend_tile(tile):
				next_tiles.append(tile)
	return next_tiles
