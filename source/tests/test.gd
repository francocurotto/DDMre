extends Node

onready var gc = $"%grandchild"
#onready var grandchild2 = $"%grandchild/%grandchild2"
onready var gc2 = find_node("grandchild2")

func _ready():
    print(gc.name)
    print(gc2.name)
    #var _gc2 = get_node("%grandchild/%grandchild2")
    #var _gc2 = get_node("%grandchild/child2/grandchild2")
    #var _gc2 = get_node("child/grandchild/%grandchild2")

