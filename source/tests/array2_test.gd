extends Node

var vec = Vector2(0,2)
var arr = [1,2,3]

func _ready():
    print(arr[vec.x])
    print(arr[vec.y])
