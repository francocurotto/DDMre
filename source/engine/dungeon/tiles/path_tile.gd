extends "tile.gd"

# preloads
const Noneobj = preload("res://engine/dungobj/noneobj.gd")

# constants
const NAME = "PATH"

# variables
var player
var content

func _init(_y, _x, _player).(_y, _x):
    player = _player
    content = Noneobj.new()

# is functions
func is_path():
    return true

func is_occupied():
    return not content.is_none()
    
func is_reachable():
    return not content.is_target()

# public functions
func empty_tile():
    content = Noneobj.new()
