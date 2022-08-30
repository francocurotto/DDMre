extends "state.gd"

# constants
const NAME = "DUNGEON"

# variables
var RollState = load("engine/states/roll_state.gd")

func _init(_player, _opponent, _dungeon).(_player, _opponent, _dungeon):
    cmdlist += ["MOVE", "ENDTURN"]

# public functions
func MOVE(cmd):
    # get data
    var pos_origin = Vector2(cmd["origin"][0], cmd["origin"][1])
    var pos_dest = Vector2(cmd["dest"][0], cmd["dest"][1])
    var tile_origin = dungeon.get_tile(pos_origin)
    var tile_dest = dungeon.get_tile(pos_dest)
    
    # get path for movement
    var path = dungeon.get_movepath(pos_origin, pos_dest)
    if path.empty(): # case not valid path found
        print("Invalid movement.")
    # case missing movement crests
    elif len(path)-1 > player.crestpool.slots["MOVEMENT"]:
        print("Not enough MOVEMENT crests.")
    else: # case valid movement
        tile_dest.content = tile_origin.content
        tile_origin.empty_tile()
        # pay the cost of the movement
        player.crestpool.slots["MOVEMENT"] -= len(path)-1
    return self
    
func ENDTURN(_cmd):
    """
    Execute the ENDTURN command.
    """
    return RollState.new(opponent, player, dungeon)    
