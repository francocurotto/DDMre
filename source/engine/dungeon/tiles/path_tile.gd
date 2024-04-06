extends "tile.gd"
## Tile that monsters can use to move.
##
## Generic path tile are not used in dungeon, instead it must be extended by
## player_path_tile and neutral_path_tile.

#region public functions
## Remove content from tile and replace it with Noneobj.
func empty_tile():
    self.content = Noneobj.new()

## Move content from [original_tile] to this tile. Original tile gets emptied.
func move_content_from(original_tile):
    # if same tile, do nothing
    if self == original_tile:
        return
    # set tile content with content from original tile
    self.content = original_tile.content
    # set previous tile (for TIME MACHINE ability)
    content.previous_tile = original_tile
    # empty original tile
    original_tile.empty_tile()
#endregion
    
#region is functions
func is_path():
    return true

## Return true if tile has no conetent (i.e. the content is Noneobj).
func is_empty():
    return content.is_none()

## Return true if a monster can reach tile as destination of a movement.
func is_reachable():
    return not content.is_target()

## Return true if [param monster] can pass through tile during a movement.
func is_passable_by(monster):
    return is_empty() or content.is_passable_by(monster)
#endregion

#region private functions
## Set a vortex in tile only if a monster lord is not located in it.
func set_vortex(_bool):
    if not content.is_monster_lord():
        vortex = _bool

## Return true if tile has a vortex.
func get_vortex():
    return vortex

## Set [param dungobj] as content of tile, and set tile as location of the
## dungobj.
func set_content(dungobj):
    content = dungobj
    content.tile = self

## Return the current content of tile.
func get_content():
    return content
#endregion

