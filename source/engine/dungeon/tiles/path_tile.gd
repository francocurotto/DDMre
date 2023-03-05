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
    content.tile = self

func get_content():
    return content

func get_playerid():
    return player.id

# public functions
func move_content_from(original_tile):
    """
    Move content from original tile to this tile. Original tile gets 
    emptied (NoneObj).
    """
    content = original_tile.content
    original_tile.empty_tile()
    # update dungobj tile references
    content.tile = self
    content.previous_tile = original_tile

# is functions
func is_path():
    return true

func is_occupied():
    return not content.is_none()

func is_reachable():
    return not content.is_target()

func is_passable(monster):
    return monster.pass_behavior.is_passable(content)

# public functions
func empty_tile():
    content = Noneobj.new()
