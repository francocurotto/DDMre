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
    if can_dimension(net): # do dimension
        dungeon.dimension(player, net, diceidx)
        Events.emit_signal("dice_dimensioned", diceidx)
        emit_signal("duel_update", cmd["name"])
        return DungeonState.new(player, opponent, dungeon)
    else: # invalid dimansion, so nothing
        return self

# private functions
func can_dimension(net):
    """
    Check if it is possible to dimension net. Return true if dimension
    is possible.
    """
    return net_inbound(net) and net_not_overlaps(net) and net_connects(net)

func net_inbound(net):
    """
    Return true if net is inbound of dungeon.
    """
    for pos in net.poslist:
        if not dungeon.pos_within_dungeon(pos):
            return false
    return true

func net_not_overlaps(net):
    """
    Return true if net does not overlaps current path in dungeon.
    """
    for pos in net.poslist:
        if not dungeon.get_tile(pos).is_empty():
            return false
    return true

func net_connects(net):
    """
    Return true if net connects player path.
    """
    for pos in net.poslist:
        for neig in dungeon.get_neighbours_poss(pos):
            var tile = dungeon.get_tile(neig)
            if tile.is_path() and tile.player == player:
                return true
    return false
