extends "tile.gd"

const Noneobj = preload("res://engine/dungobj/noneobj.gd")
const NAME = "PATH"

var player
var player_id setget , get_player_id
var content

func _init(_player):
    player = _player
    content = Noneobj.new()

func get_player_id():
    return player.id

func is_path():     return true
func is_occupied(): return content.is_content()
