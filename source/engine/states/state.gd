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
    # check for correct syntax in command
    if not call("check_syntax_" + cmd["name"], cmd):
        return self
    # check for correct context in command
    elif not call("check_context_" + cmd["name"], cmd):
        return self
    # run command if checks passed
    return call("run_" + cmd["name"], cmd)
