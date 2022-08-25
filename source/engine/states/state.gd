extends Reference

# variables
var player
var opponent
var dungeon
var cmdlist = []

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

func is_other_turn(state):
    """
    Check if this state and input state are not the same turn.
    """
    return player != state.player
