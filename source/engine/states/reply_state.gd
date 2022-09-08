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
func GUARD(cmd):
    """
    Excecute the GUARD command.
    """
    emit_signal("duel_update", cmd["name"])
    return DungeonState.new(opponent, player, dungeon)

# public functions
func WAIT(cmd):
    """
    Excecute the WAIT command.
    """
    emit_signal("duel_update", cmd["name"])
    return DungeonState.new(opponent, player, dungeon)
