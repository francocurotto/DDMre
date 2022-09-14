extends Reference

# preloads
const Noneobj = preload("res://engine/dungobj/noneobj.gd")

# variables
var pos
var content setget set_content, get_content

func _init(y, x):
    pos = Vector2(x, y)
    content = Noneobj.new()

# setget functions
func set_content(_dungobj):
    """
    Set Noneobj for default tile.
    """
    content = Noneobj.new()

func get_content():
    """
    Returns Noneobj for default tile.
    """
    return Noneobj.new()

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
