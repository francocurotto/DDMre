extends "tile.gd"
## 

func _init(_y, _x):
    super(_y, _x)
    pass

# setget functions
func set_vortex(_bool):
    if  not content.is_monster_lord():
        vortex = _bool

func get_vortex():
    return vortex

func set_content(dungobj):
    content = dungobj
    content.tile = self

func get_content():
    return content

# public functions
func empty_tile():
    self.content = Noneobj.new()

func move_content_from(original_tile):
    """
    Move content from original tile to this tile. Original tile gets 
    emptied (NoneObj).
    """
    # if same tile, do nothing
    if self == original_tile:
        return
    # set tile content with content from original tile
    self.content = original_tile.content
    # set previous tile (for TIME MACHINE ability)
    content.previous_tile = original_tile
    # empty original tile
    original_tile.empty_tile()
    
# is functions
func is_path():
    return true

func is_empty():
    return content.is_none()

func is_reachable():
    return not content.is_target()

func is_passable_by(monster):
    return is_empty() or content.is_passable_by(monster)
