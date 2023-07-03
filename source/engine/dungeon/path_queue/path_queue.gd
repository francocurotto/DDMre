extends Reference

var dungeon
var monster
var paths
var tiles setget , get_tiles

func _init(_dungeon, _monster):
    dungeon = _dungeon
    monster = _monster
    init_paths()
    fill_paths()

# setget functions
func get_tiles():
    var dests = []
    for path in paths:
        dests.append(path.dest)
    return dests

func get_path(dest):
    for path in paths:
        if path.dest == dest:
            return path

func get_max_tiles():
    pass

# private functions
func init_paths():
    pass

func fill_paths():
    for path in paths:
        for new_path in path.get_new_paths(get_max_tiles()):
            if not new_path.dest in self.tiles:
                paths.append(new_path)

