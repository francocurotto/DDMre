extends Reference

# preloads
const Noneobj = preload("res://engine/dungobj/noneobj.gd")

# variables
var pos
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
    return null

# is functions
func is_path():
    return false

func is_block():
    return false

func is_occupied():
    return false

func is_reachable():
    return false

func is_passable():
    return false
