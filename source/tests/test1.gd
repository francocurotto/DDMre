extends Node

const Test2 = preload("test2.gd")

func _ready():
    var _test2 = Test2.new("a", "b")
    var _test3 = Test2.new()
