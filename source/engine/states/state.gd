extends RefCounted

# variables
var player
var opponent
var dungeon

func _init(_player, _opponent, _dungeon):
    player = _player
    opponent = _opponent
    dungeon = _dungeon

# public functions
func update(cmddict):
    """
    Update state given command dict cmddict.
    """
    # run command
    var new_state = call(cmddict["cmd"], cmddict)
    Events.emit_signal("duel_update")
    return new_state
