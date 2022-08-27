extends "state.gd"

# constants
const NAME = "DUNGEON"

# variables
var RollState = load("engine/states/roll_state.gd")

func _init(_player, _opponent, _dungeon).(_player, _opponent, _dungeon):
    cmdlist += ["MOVE", "ENDTURN"]

# public functions
func MOVE(cmd):
    var tile_origin = dungeon.array[cmd["origin"][0]][cmd["origin"][1]]
    var tile_dest = dungeon.array[cmd["dest"][0]][cmd["dest"][1]]
    tile_dest.content = tile_origin.content
    tile_origin.empty_tile()
    return self
    
func ENDTURN(_cmd):
    """
    Execute the ENDTURN command.
    """
    return RollState.new(opponent, player, dungeon)    
