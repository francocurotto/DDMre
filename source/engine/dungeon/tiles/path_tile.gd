extends "tile.gd"

# constants
const NAME = "PATH"

# variables
var player

func _init(_y, _x, _player).(_y, _x):
    player = _player

# setget functions
func set_content(dungobj):
    content = dungobj

func get_content():
    return content

func get_playerid():
    return player.id

func get_dungobjid():
    return null

# is functions
func is_path():
    return true

func is_occupied():
    return not content.is_none()

func is_reachable():
    return not content.is_target()

func is_passable(monster):
    return monster.pass_behavior.is_passable(content)
    #return content.is_none()

# public functions
func empty_tile():
    content = Noneobj.new()
