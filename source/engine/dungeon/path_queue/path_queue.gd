extends Reference

var dungeon
var monster
var paths
var tiles setget , get_tiles

func _init(_dungeon, _monster):
    dungeon = _dungeon
    monster = _monster
    paths = [[monster.tile]]
    fill_paths()

# setget functions
func get_tiles():
    var dests = []
    for path in paths:
        dests.append(path[-1])
    return dests

func get_path(dest):
    for path in paths:
        if path[-1] == dest:
            return path

# private functions
func fill_paths():
    for path in paths:
        for next_tile in get_next_tiles(path):
            if not next_tile in self.tiles:
                var new_path = path.duplicate().append(next_tile)
                paths.append(new_path)

func get_next_tiles(_path):
    pass
