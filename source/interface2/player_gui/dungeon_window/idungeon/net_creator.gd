extends Node

# constants
const INITDICT = {1:[], 2:["FUD"]}
const NETS = ["X1", "T1", "Z1", "X2", "T2", "Z2", "M1", "M2", "S1", "S2", "L1"]
const ROTATIONS = [[], ["TCW"], ["TCW", "TCW"], ["TAW"]]

# variables
var pos
var inittrans
var x_reflect = false
var y_reflect = false
var netidx = 10
var refidx = 0
var rotidx = 0

func _init(playerid):
    inittrans = INITDICT[playerid]

# public functions
func create_net(_pos):
    pos = _pos
    var netdata = get_netdata()
    var net = Globals.create_net(netdata["netname"])
    net.offset(pos)
    net.apply_trans_list(netdata["trans_list"])
    return net

func get_netdata():
    var netname = NETS[netidx]
    var trans_list = inittrans
    if x_reflect:
        trans_list.append("FLR")
    if y_reflect:
        trans_list.append("FUD")
    trans_list += ROTATIONS[rotidx]
    return {"netname":netname, "trans_list":trans_list}
