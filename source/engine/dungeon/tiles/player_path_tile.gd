extends "path_tile.gd"
## Tile that monsters can use to move, and belong to a player.
##
## Player tile monsters are usually place when a player dimension a dice. They
## are also place at the star of the duel in the monster lord location.

#region constants
const TYPE = "PLAYER"
#endregion

#region variables
var player # Player owner of the path tile
#endregion

#region builtin functions
func _init(_y, _x, _player):
    super(_y, _x)
    player = _player
#endregion

#region is functions
func is_player_path():
    return true
#endregion

#region functions
func get_player_id():
    return player.id
#endregion

