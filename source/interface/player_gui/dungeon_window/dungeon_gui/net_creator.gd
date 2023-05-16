extends Node

# constants
const INITDICT = {1:[], 2:["FUD"]}
const ROTATIONS = [[], ["TCW"], ["TCW", "TCW"], ["TAW"]]

# variables
var playerid
var pos
var inittrans
var rot_index = 0
var netname = "L1"
var reflections = []

# signals
signal net_updated(net)

# setget functions
func set_playerid(_playerid):
    playerid = _playerid
    inittrans = INITDICT[playerid]

# public functions
func update_net_index(_netname, _reflections):
    netname = _netname
    reflections = _reflections
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
    var trans_list = inittrans + reflections + ROTATIONS[rot_index]
    return {"netname":netname, "pos":pos, "trans_list":trans_list}
