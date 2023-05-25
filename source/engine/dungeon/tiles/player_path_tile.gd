extends "path_tile.gd"

# variables
var player

func _init(_y, _x, _player).(_y, _x):
    player = _player

# setget functions
func get_playerid():
    return player.id

# is functions
func is_player_path():
    return true
