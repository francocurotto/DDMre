extends "state.gd"

# constants
const NAME = "DIMENSION"

# variables
var dim_candidates
var DungeonState = load("engine/states/dungeon_state.gd")

func _init(_player, _opponent, _dungeon, _dim_candidates).(_player, _opponent, _dungeon):
    dim_candidates = _dim_candidates

func SKIP(_cmd):
    """
    Execute the SKIP command.
    """
    return DungeonState.new(player, opponent, dungeon)

func DIM(cmd):
    """
    Excecute the DIM command.
    """
    # get data
    var diceidx = cmd["dice"]
    var netname = cmd["net"]
    var pos = cmd["pos"]
    var trans_list = cmd["trans"]
    
    # create and transorm net
    var net = Globals.create_net(netname)
    net.offset(pos)
    net.apply_trans_list(trans_list)

    # verify for valid dimension
    if dungeon.can_dimension(player, net):
        var dice = player.dicepool[diceidx]
        dungeon.dimension(player, net, dice)
    else:
        return self
    
    return DungeonState.new(player, opponent, dungeon)

# private functions
func create_net(_netname):
    return null
