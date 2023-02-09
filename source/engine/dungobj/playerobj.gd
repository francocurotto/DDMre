extends "dungobj.gd"

# variables
var player
var tile

func _init(_player):
    player = _player

# setget functions
func get_playerid():
    return player.id
