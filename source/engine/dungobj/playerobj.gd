extends "dungobj.gd"

# variables
var player
var player_id setget , get_player_id

func _init(_player):
    player = _player

# public functions
func get_player_id():
    return player.id
