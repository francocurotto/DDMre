extends RefCounted
## Current state of the engine.
##
## The state holds all the information of the duel for its correct progression,
## which correspond to the players and the dungeon current information. It also 
## runs input commands from the player 
var player   ## Current player of the state
var opponent ## Current opponent of the state
var dungeon  ## Dungeon of the state

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
