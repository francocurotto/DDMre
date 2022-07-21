extends "state.gd"

const NAME = "DUNGEON"

var RollState = load("engine/states/roll_state.gd")

func _init(_player, _opponent).(_player, _opponent):
    cmdlist += ["ENDTURN"]
    
func ENDTURN(_cmd):
    return RollState.new(opponent, player)    
