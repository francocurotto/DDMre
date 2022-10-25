extends Node

# variables
var active
var pos
var inittrans
var rotidx = 0
var rotations
var nridx = 0
var nets_reflects = [["X1", []],
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

# signals
signal net_updated(pos)

func _init(playerid):
    var initdict = {1:[], 2:["FUD"]}
    var rotdict = {1: [[], ["TCW"], ["TCW", "TCW"], ["TAW"]],
                   2: [[], ["TAW"], ["TAW", "TAW"], ["TCW"]]}
    inittrans = initdict[playerid]
    rotations = rotdict[playerid]

# public functions
func create_net(_pos):
    active = true
    pos = _pos
    var netdata = get_netdata()
    var net = Globals.create_net(netdata["netname"])
    net.offset(pos)
    net.apply_trans_list(netdata["trans_list"])
    return net

func get_netdata():
    var net_reflect = nets_reflects[nridx]
    var netname = net_reflect[0]
    var reflect = net_reflect[1]
    var rotation = rotations[rotidx]
    return {"netname":netname, "trans_list":inittrans+reflect+rotation}

# signals callbacks
func _input(event):
    if active:
        if event is InputEventMouseButton and event.pressed:
            if event.button_index == BUTTON_WHEEL_UP:
                nridx = (nridx+1) % len(nets_reflects)
            elif event.button_index == BUTTON_WHEEL_DOWN:
                nridx =  (nridx-1) % len(nets_reflects)
            elif event.button_index == BUTTON_RIGHT:
                rotidx = (rotidx+1) % len(rotations)
            elif event.button_index == BUTTON_MIDDLE:
                rotidx = (rotidx-1) % len(rotations)
            emit_signal("net_updated", pos)

