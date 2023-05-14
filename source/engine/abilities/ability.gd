extends Reference

# variables
var name
var dungeon

func _init(ability_info):
    name = ability_info["NAME"]

# public functions
func initialize(_summon, _dungeon):
    dungeon = _dungeon

func enable():
    pass

func disable():
    pass

# is functions
func is_standing():
    return false

func is_dim_state():
    return false

func is_item_state():
    return false
