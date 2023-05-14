extends "state.gd"

# constants
const NAME = "DIMENSION"

# variables
var dim_candidates
var DungeonState = load("engine/states/dungeon_state.gd")
var DimAbilityState = load("engine/states/dim_ability_state.gd")

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
    if dungeon.can_dimension(net, player): # do dimension
        var summon = dungeon.dimension(player, net, diceidx)
        Events.emit_signal("duel_update")
        if summon.get_dim_state_ability():
            return DimAbilityState.new(player, opponent, dungeon, summon)
        else:
            return DungeonState.new(player, opponent, dungeon)
    else: # invalid dimension, so nothing
        return self
