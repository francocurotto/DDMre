extends "tile.gd"
## Tile that blocks dimension and movement from monsters.
##
## Block tiles are usually place at the start of a duel in custom dungeons.

#region constants
const TYPE = "BLOCK"
#endregion

#TODO: test and remove
#func _init(y, x):
#    super(y, x)
#    pass

#region is functions
func is_block():
    return true
#endregion
