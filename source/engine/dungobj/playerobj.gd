extends "dungobj.gd"

var player
var player_id setget , get_player_id

func _init(_player):
    player = _player

func get_player_id():
    return player.id
