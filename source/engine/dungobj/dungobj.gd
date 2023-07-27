extends RefCounted

# variable
var playerid : get = get_playerid
var tile : set = set_tile

# setget functions
func get_playerid():
    return 0

func set_tile(_tile):
    pass

# is functions
func is_none():
    return false

func is_summon():
    return false

func is_monster():
    return false

func is_item():
    return false

func is_monster_lord():
    return false

func is_target():
    return is_monster() or is_monster_lord()

func is_passable_by(_monster):
    return false
