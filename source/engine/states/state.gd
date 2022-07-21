extends Reference

var player
var opponent
var cmdlist = []

func _init(_player, _opponent):
    player = _player
    opponent = _opponent

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
