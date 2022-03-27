extends SceneTree

func _init():
    var Engine = load("res://engine/engine.gd")
    var engine = Engine.new()
    print(engine.dicelib)
    engine.free()
    quit()
