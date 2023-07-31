extends RefCounted
## Create a dice net for dimension.
##
## The net creator 

# constants
const NetT1 = preload("res://engine/dungeon/nets/net_t1.gd")
const NetT2 = preload("res://engine/dungeon/nets/net_t2.gd")
const NetZ1 = preload("res://engine/dungeon/nets/net_z1.gd")
const NetZ2 = preload("res://engine/dungeon/nets/net_z2.gd")
const NetX1 = preload("res://engine/dungeon/nets/net_x1.gd")
const NetX2 = preload("res://engine/dungeon/nets/net_x2.gd")
const NetM1 = preload("res://engine/dungeon/nets/net_m1.gd")
const NetM2 = preload("res://engine/dungeon/nets/net_m2.gd")
const NetS1 = preload("res://engine/dungeon/nets/net_s1.gd")
const NetS2 = preload("res://engine/dungeon/nets/net_s2.gd")
const NetL1 = preload("res://engine/dungeon/nets/net_l1.gd")

# static functions
static func create_net(netname, pos, trans_list):
    """
    Given a net name, position in dungeon and a list of transformation,
    create a net with the correct positions.
    """
    var net
    match netname:
        "T1" : net = NetT1.new()
        "T2" : net = NetT2.new()
        "Z1" : net = NetZ1.new()
        "Z2" : net = NetZ2.new()
        "X1" : net = NetX1.new()
        "X2" : net = NetX2.new()
        "M1" : net = NetM1.new()
        "M2" : net = NetM2.new()
        "S1" : net = NetS1.new()
        "S2" : net = NetS2.new()
        "L1" : net = NetL1.new()
    net.offset(pos)
    net.apply_trans_list(trans_list)
    return net
