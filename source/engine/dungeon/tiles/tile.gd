extends Reference

# preloads
const Noneobj = preload("res://engine/dungobj/noneobj.gd")

# variables
var pos
var vortex = false
var content setget set_content, get_content
var playerid setget , get_playerid

func _init(y, x):
    pos = Vector2(x, y)
    content = Noneobj.new()

# setget functions
func set_content(_dungobj):
    content = Noneobj.new()

func get_content():
    return Noneobj.new()

func get_playerid():
    return 0

# is functions
func is_empty():
    return false

func is_path():
    return false

func is_block():
    return false

func is_occupied():
    return false

func is_reachable():
    return false

func is_passable(_monster):
    return false
