extends RefCounted
## Create a dice net for dimension.
##
## Library to create a dice net from the net name, and apply offset and 
## transformation.

# constants
const NETS_DICT = { ## Dictionary that maps net names to scripts
    "T1" = preload("res://engine/dungeon/nets/net_t1.gd"),
    "T2" = preload("res://engine/dungeon/nets/net_t2.gd"),
    "Z1" = preload("res://engine/dungeon/nets/net_z1.gd"),
    "Z2" = preload("res://engine/dungeon/nets/net_z2.gd"),
    "X1" = preload("res://engine/dungeon/nets/net_x1.gd"),
    "X2" = preload("res://engine/dungeon/nets/net_x2.gd"),
    "M1" = preload("res://engine/dungeon/nets/net_m1.gd"),
    "M2" = preload("res://engine/dungeon/nets/net_m2.gd"),
    "S1" = preload("res://engine/dungeon/nets/net_s1.gd"),
    "S2" = preload("res://engine/dungeon/nets/net_s2.gd"),
    "L1" = preload("res://engine/dungeon/nets/net_l1.gd"),
}

# static functions
## Create the appropiate net object, given the [param netname] net name. Then
## apply the [param offset] translation and the [param trans_list] list of
## transformation to the created net.
static func create_net(netname, pos, trans_list):
    """
    Given a net name, position in dungeon and a list of transformation,
    create a net with the correct positions.
    """
    var net = NETS_DICT[netname].new()
    net.add_offset(pos)
    net.apply_trans_list(trans_list)
    return net
