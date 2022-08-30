extends Reference

var pos

func _init(y, x):
    pos = Vector2(x, y)

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
