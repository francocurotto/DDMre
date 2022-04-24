extends "dungobj.gd"

const NAME = "MONSTER_LORD"

var player
var player_id setget , get_player_id

func _init(_player):
    player = _player

func get_player_id():
    return player.id
