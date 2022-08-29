extends Reference

var pos

func _init(y, x):
    pos = Pos.new(y, x)

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

class Pos:
    """
    Class for position of tiles in dungeon.
    """
    var y
    var x
    
    func _init(_y, _x):
        y = _y
        x = _x
    
    func toarray():
        return [y,x]
    
    func add_array(array):
        return Pos.new(y+array[0], x+array[1])
