extends Node

# constants
const INITDICT = {1:[], 2:["FUD"]}
const NETS = ["X1", "T1", "Z1", "X2", "T2", "Z2", "M1", "M2", "S1", "S2", "L1"]
const REFLECTSX = [[], ["FLR"]]
const REFLECTSY = [[], ["FUD"]]
const ROTATIONS = [[], ["TCW"], ["TCW", "TCW"], ["TAW"]]

# variables
var playerid
var pos
var inittrans
var x_reflect = false
var y_reflect = false
var netidx = 10
var refxidx = 0
var refyidx = 0
var rotidx = 0

func _init(_playerid):
    playerid = _playerid
    inittrans = INITDICT[playerid]

# public functions
func update_net_pos(_pos):
    pos = _pos
    return create_net()

func update_net_flr():
    refxidx = (refxidx+1) % len(REFLECTSX)
    return create_net()

func update_net_fud():
    refyidx = (refyidx+1) % len(REFLECTSY)
    return create_net()

func update_net_tcw():
    var adder = -(playerid*2-3)
    rotidx = (rotidx+adder) % len(ROTATIONS)
    return create_net()

func update_net_taw():
    var adder = playerid*2-3
    rotidx = (rotidx+adder) % len(ROTATIONS)
    return create_net()

func create_net():
    var netdata = get_netdata()
    var net = Globals.create_net(netdata["netname"])
    net.offset(pos)
    net.apply_trans_list(netdata["trans_list"])
    return net

func get_netdata():
    var netname = NETS[netidx]
    var trans_list = inittrans + ROTATIONS[rotidx] + REFLECTSX[refxidx] + REFLECTSY[refyidx]
    return {"netname":netname, "trans_list":trans_list}
