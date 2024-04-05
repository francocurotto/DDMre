extends "dungobj.gd"

# variables
var player

func _init(_player):
    player = _player

# setget functions
func get_player_id():
    return player.id

func set_tile(_tile):
    tile = _tile
