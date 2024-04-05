extends "path_tile.gd"

# constant
const TYPE = "PLAYER"

# variables
var player

func _init(_y, _x, _player):
    super(_y, _x)
    player = _player

# setget functions
func get_player_id():
    return player.id

# is functions
func is_player_path():
    return true
