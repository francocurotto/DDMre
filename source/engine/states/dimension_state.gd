extends "state.gd"

# constants
const NAME = "DIMENSION"

# preloads
const Checks = preload("res://engine/checks.gd")

# variables
var dim_candidates
var DungeonState = load("engine/states/dungeon_state.gd")
var DimAbilityState = load("engine/states/dim_ability_state.gd")
var NetCreator = load("res://engine/states/net_creator.gd")

func _init(_player, _opponent, _dungeon, _dim_candidates).(_player, _opponent, _dungeon):
    dim_candidates = _dim_candidates

# public functions
func run_SKIP(_cmd):
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

    # create net
    var net = NetCreator.create_net(netname, pos, trans_list)

    # dimension
    var summon = dungeon.dimension(player, net, diceidx)
    Events.emit_signal("duel_update")
    
    # dice to go to dungeon or dim ability state
    if summon.has_dim_state_ability():
        return DimAbilityState.new(player, opponent, dungeon, summon)
    else:
        return DungeonState.new(player, opponent, dungeon)
