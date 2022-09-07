extends "state.gd"

# constants
const NAME = "REPLY"

# variables
var DungeonState = load("engine/states/dungeon_state.gd")
var attacker
var attacked

func _init(_player, _opponent, _dungeon, _attacker, _attacked).(_player, _opponent, _dungeon):
    attacker = _attacker
    attacked = _attacked
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
