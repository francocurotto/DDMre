extends Node

const Test2 = preload("test2.gd")

func _ready():
    var test2 = Test2.new(1)
    var test3 = test2.duplicate()
    print(test3.i)
