extends "state.gd"

# constants
const NAME = "REPLY"

# variables
var DungeonState = load("engine/states/dungeon_state.gd")

func _init(_player, _opponent, _dungeon).(_player, _opponent, _dungeon):
    cmdlist += ["GUARD", "WAIT"]

# public functions
func GUARD(_cmd):
    """
    Excecute the GUARD command.
    """
    pass

# public functions
func WAIT(_cmd):
    """
    Excecute the WAIT command.
    """
    pass
