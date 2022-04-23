extends "tile.gd"

const Dungobj = preload("res://engine/dungobj/dungobj.gd")
const NAME = "PATH"

var player
var content

func _init(_player):
    player = _player
    content = Dungobj.new()
