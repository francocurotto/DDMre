extends Node

func _ready():
    var net = Globals.create_net("X1")
    print(net.poslist)
    net.offset(Vector2(100,-100))
    print(net.poslist)
    print(net.centerpos)
