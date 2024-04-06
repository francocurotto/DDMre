extends "tile.gd"
## Tile that can be turn into a path tile via a dice dimension.
##
## Open tiles compose most of the dungeon at the start of the duel. Monsters 
## cannot move or attack through them so they should be replaced with path 
## tiles via dice dimensions.

#region constants
const TYPE = "OPEN"
#endregion

#TODO: test and remove
#func _init(y, x):
#    super(y, x)
#    pass

#region is functions
func is_open():
    return true
#endregion
