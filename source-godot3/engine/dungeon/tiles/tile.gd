extends Reference

# preloads
const Noneobj = preload("res://engine/dungobj/noneobj.gd")

# variables
var pos
var vortex = false setget set_vortex, get_vortex
var content setget set_content, get_content
var playerid setget , get_playerid

func _init(y, x):
    # GODOT4: change to vector2i
    pos = Vector2(x, y)
    content = Noneobj.new()

# setget functions
func set_vortex(_bool):
    pass

func get_vortex():
    return false

func set_content(_dungobj):
    pass

func get_content():
    return Noneobj.new()

func get_playerid():
    return 0

# public functions
func tile_range(tile):
    var x_range = abs(pos.x-tile.pos.x)
    var y_range = abs(pos.y-tile.pos.y)
    var range_dist = x_range + y_range
    return range_dist

# is functions
func is_open():
    return false

func is_path():
    return false

func is_player_path():
    return false

func is_block():
    return false

func is_empty():
    return false

func is_reachable():
    return false

func is_passable_by(_monster):
    return false
