extends Reference

var dungeon
var monster
var paths
var tiles

func _init(_dungeon, _monster):
    dungeon = _dungeon
    monster = _monster
    paths = [[monster.tile]]
    tiles = [monster.tile]
    fill_paths()

# setget functions
func get_path(dest):
    for path in paths:
        if path[-1] == dest:
            return path
    return []

# private functions
func fill_paths():
    for path in paths:
        for next_tile in get_next_tiles(path):
            if not next_tile in tiles:
                var new_path = path.duplicate()
                new_path.append(next_tile)
                paths.append(new_path)
                tiles.append(next_tile)

func get_next_tiles(path):
    var next_tiles = []
    if is_path_extendable(path):
        for tile in dungeon.get_neighbours_tiles(path[-1]):
            if tile != path[-1] and tile.is_reachable():
                next_tiles.append(tile)
    return next_tiles

# is functions
func is_path_extendable(_path):
    pass

func is_extend_tile(_tile):
    pass

func print_paths():
    for path in paths:
        print_path(path)

func print_path(path):
    var pathpos = []
    for tile in path:
        pathpos.append(tile.pos)
    print(",".join(pathpos))