extends Reference

# variable
var playerid setget , get_playerid

# setget functions
func get_playerid():
    return null

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
