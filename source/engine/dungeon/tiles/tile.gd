extends Reference

var y
var x
var pos setget , get_pos

func _init(_y, _x):
    y = _y
    x = _x

# public functions
func get_pos():
    return [y, x]

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
