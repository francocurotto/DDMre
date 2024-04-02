extends RefCounted

# preloads
const Noneobj = preload("res://engine/dungobj/noneobj.gd")

# variables
var pos
var vortex = false: get = get_vortex, set = set_vortex
var content : get = get_content, set = set_content
var playerid : get = get_playerid

func _init(y, x):
    pos = Vector2i(x, y)
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
