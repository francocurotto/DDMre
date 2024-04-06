extends "path_tile.gd"

#region constants
const TYPE = "PLAYER"
#endrefion

#region variables
var player # Player owner of the path tile
#endregion

func _init(_y, _x, _player):
    super(_y, _x)
    player = _player

# setget functions
func get_playerid():
    return player.id

# is functions
func is_player_path():
    return true
