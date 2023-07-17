extends Reference

# variables
var player
var opponent
var dungeon

func _init(_player, _opponent, _dungeon):
    player = _player
    opponent = _opponent
    dungeon = _dungeon

# public functions
func update(cmd):
    """
    Update state given command cmd.
    """
    # run command if checks passed
    return call(cmd["name"], cmd)
