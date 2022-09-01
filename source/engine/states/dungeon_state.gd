extends "state.gd"

# constants
const NAME = "DUNGEON"

# variables
var RollState = load("engine/states/roll_state.gd")

func _init(_player, _opponent, _dungeon).(_player, _opponent, _dungeon):
    cmdlist += ["MOVE", "ENDTURN"]

# public functions
func MOVE(cmd):
    """
    Excecute the MOVE command.
    """
    # get data
    var pos_origin = Vector2(cmd["origin"][0], cmd["origin"][1])
    var pos_dest = Vector2(cmd["dest"][0], cmd["dest"][1])
    var tile_origin = dungeon.get_tile(pos_origin)
    var tile_dest = dungeon.get_tile(pos_dest)
    
    # get path for movement
    var path = dungeon.get_movepath(pos_origin, pos_dest)
    if path.empty(): # case not valid path found
        print("Destination cannot be reached.")
    # case missing movement crests
    elif len(path)-1 > player.crestpool.slots["MOVEMENT"]:
        print("Not enough MOVEMENT crests.")
    else: # case valid movement
        move_dungobj(tile_origin, tile_dest)
        # pay the cost of the movement
        player.crestpool.slots["MOVEMENT"] -= len(path)-1
        # emit update signal
        emit_signal("duel_update", cmd["name"])
    return self

func ATTACK(cmd):
    """
    Excecute the ATTACK command.
    """
    # get data
    var pos_origin = Vector2(cmd["origin"][0], cmd["origin"][1])
    var pos_dest = Vector2(cmd["dest"][0], cmd["dest"][1])
    var tile_origin = dungeon.get_tile(pos_origin)
    var tile_dest = dungeon.get_tile(pos_dest)

    # check valid attack
    if not pos_dest in dungeon.get_attackposs(player, pos_origin):
        print("Target out of reach.")
    # check enough ATTACK crests
    elif  player.crestpool.slots["ATTACK"] < 1:
        print("Not enough ATTACK crests.")
    # valid attack
    else:
        var monster = tile_origin.content
        var target = tile_dest.content
        monster.attack(target)
        # pay the cost of attack
        player.crestpool.slots["ATTACK"] -= 1
    return self
    
func ENDTURN(_cmd):
    """
    Execute the ENDTURN command.
    """
    return RollState.new(opponent, player, dungeon)

func move_dungobj(tile1, tile2):
    """
    Move content from tile1 to tile2. Content in tile2 in overwritten.
    """
    tile2.content = tile1.content
    tile1.empty_tile()
        
