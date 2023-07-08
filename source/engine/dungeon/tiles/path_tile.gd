extends "tile.gd"

func _init(_y, _x).(_y, _x):
    pass

# setget functions
func set_content(dungobj):
    print("seting content")
    content = dungobj
    content.tile = self
    print(content.NAME)
    print("done")

# public functions
func empty_tile():
    content = Noneobj.new()

func move_content_from(original_tile):
    """
    Move content from original tile to this tile. Original tile gets 
    emptied (NoneObj).
    """
    # if same tile, do nothing
    if self == original_tile:
        return
    # set tile content with content from original tile
    set_content(original_tile.content)
    # set previou tile (for TIME MACHINE ability)
    content.previous_tile = original_tile
    # empty original tile
    original_tile.empty_tile()
    
# is functions
func is_path():
    return true

func is_reachable():
    return not content.is_target()
