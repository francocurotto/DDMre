extends Reference

# variables
var player
var opponent
var dungeon
var cmdlist = []

# signals
signal duel_update(cmdname)

func _init(_player, _opponent, _dungeon):
    player = _player
    opponent = _opponent
    dungeon = _dungeon

# public functions
func update(cmd):
    """
    Update state given command cmd.
    """
    return call(cmd["name"], cmd)
