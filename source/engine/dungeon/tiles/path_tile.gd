extends "tile.gd"

const Dungobj = preload("res://engine/dungobj/dungobj.gd")
const NAME = "PATH"

var player
var player_id setget , get_player_id
var content

func _init(_player):
    player = _player
    content = Dungobj.new()

func get_player_id():
    return player.id
