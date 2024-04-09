extends "dungobj.gd"
## A dungobj that is own by a player and is located in a tile of the dungeon.
##
## Playerobj must be extended by other classes to be properly used in a duel.

#region variables
var player ## Player that owns the dungobj
#endregion

#region builtin functions
func _init(_player):
    player = _player
#endregion

#region private functions
## Return the ID of the player that owns the dungobj.
func get_player_id():
    return player.id

## Return the tile where the dungobj is located.
func set_tile(_tile):
    tile = _tile
#endregion
