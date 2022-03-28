extends SceneTree
const Engine = preload("res://engine/engine.gd")

func _init():
    var engine = Engine.new()
    quit()
