extends RefCounted
## Current state of the engine.
##
## Base state from which the actual states inheritates from. The state holds 
## all the information of the duel for its correct progression, which 
## correspond to the players and the dungeon current information. It also runs
## input commands from the player.

var player   ## Current player of the state
var opponent ## Current opponent of the state
var dungeon  ## Dungeon of the state

func _init(_player, _opponent, _dungeon):
    player = _player
    opponent = _opponent
    dungeon = _dungeon

# public functions
## Run a player command defined in [param cmddict] dictionary. The command name
## is specified in the "cmd" key, and the current state must have a function 
## with the same name. The [param cmddict] must also have the corresponding
## parameters to run the command. The "duel_update" signal is emmited to update
## interfaces, and the new state resulting from the command is returned (it
## could be the same state as [code]self[/code].
func update(cmddict):
    # run command
    var new_state = call(cmddict["cmd"], cmddict) # run command
    Events.duel_update.emit() # emit duel_update
    return new_state # return new state
