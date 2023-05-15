extends Node

# constants
const INITDICT = {1:[], 2:["FUD"]}
const NETS = [["X1", []],
              ["T1", []],
              ["Z1", []], 
              ["Z1", ["FLR"]], 
              ["X2", []], 
              ["X2", ["FLR"]], 
              ["T2", []], 
              ["T2", ["FLR"]],
              ["Z2", []], 
              ["Z2", ["FLR"]], 
              ["M1", []], 
              ["M1", ["FLR"]], 
              ["M2", []], 
              ["M2", ["FLR"]], 
              ["S1", []], 
              ["S1", ["FLR"]], 
              ["S2", []], 
              ["S2", ["FLR"]], 
              ["L1", []],
              ["L1", ["FLR"]]]
const ROTATIONS = [[], ["TCW"], ["TCW", "TCW"], ["TAW"]]

# variables
var playerid
var pos
var inittrans
var net_index
var rot_index

# signals
signal net_updated(net)

# setget functions
func set_playerid(_playerid):
    playerid = _playerid
    inittrans = INITDICT[playerid]

# public functions
func reset():
    net_index = 18
    rot_index = 0

func update_net_index(adder):
    net_index = (net_index+adder) % len(NETS)
    create_net()

func update_net_pos(_pos):
    pos = _pos
    create_net()

func update_net_tcw():
    var adder = -(playerid*2-3)
    rot_index = (rot_index+adder) % len(ROTATIONS)
    create_net()

func update_net_taw():
    var adder = playerid*2-3
    rot_index = (rot_index+adder) % len(ROTATIONS)
    create_net()

func create_net():
    var netdata = get_netdata()
    var net = Globals.create_net(netdata["netname"])
    net.offset(netdata["pos"])
    net.apply_trans_list(netdata["trans_list"])
    emit_signal("net_updated", net)

func get_netdata():
    
    var netname = NETS[net_index][0]
    var trans_list = inittrans + NETS[net_index][1] + ROTATIONS[rot_index]
    return {"netname":netname, "pos":pos, "trans_list":trans_list}
