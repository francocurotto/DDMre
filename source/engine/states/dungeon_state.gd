extends "state.gd"

# constants
const NAME = "DUNGEON"

# variables
var RollState = load("engine/states/roll_state.gd")

func _init(_player, _opponent).(_player, _opponent):
    cmdlist += ["ENDTURN"]

# public functions
func ENDTURN(_cmd):
    """
    Execute the ENDTURN command.
    """
    return RollState.new(opponent, player)    
