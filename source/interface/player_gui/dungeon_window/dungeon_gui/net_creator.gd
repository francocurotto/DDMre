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
var net_index = 10
var refx_index = 0
var refy_index = 0
var rot_index = 0

# signals
signal net_updated(net)

# setget functions
func set_playerid(_playerid):
    playerid = _playerid
    inittrans = INITDICT[playerid]

# public functions
func reset():
    net_index = 10
    refx_index = 0
    refy_index = 0
    rot_index = 0

func update_net_index(_net_index):
    net_index = _net_index
    create_net()

func update_net_pos(_pos):
    pos = _pos
    create_net()

func update_net_flr():
    refx_index = (refx_index+1) % len(REFLECTSX)
    create_net()

func update_net_fud():
    refy_index = (refy_index+1) % len(REFLECTSY)
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
    var netname = NETS[net_index]
    var trans_list = inittrans + ROTATIONS[rot_index] + REFLECTSX[refx_index] + REFLECTSY[refy_index]
    return {"netname":netname, "pos":pos, "trans_list":trans_list}
