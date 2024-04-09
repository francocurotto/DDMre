extends RefCounted
## Dungobj is a generic entity that resides in the dungeon.
##
## Dungobj means dungeon object. A dungobj interacts with other dungobjs
## in the dungeon to advance the game state. Must be extended by other classes
## to be properly used in a duel.

#region variable
var player_id : get = get_player_id ## ID of the player that owns the dungobj
var tile : set = set_tile ## Tile in the dungeon where the dungobj is located
#endregion

#region is functions
## By default, dungobjs are not none.
func is_none():
    return false

## By default, dungobjs are not summon.
func is_summon():
    return false

## By default, dungobjs are not monsters.
func is_monster():
    return false

## By default, dungobjs are not items.
func is_item():
    return false

## By default, dungobjs are not monster lords.
func is_monster_lord():
    return false

## By default, dungobjs are not passable by [param _monsters].
func is_passable_by(_monster):
    return false

## Dungobj are are targets if they are monsters or monster lords.
func is_target():
    return is_monster() or is_monster_lord()
#endregion

#region private functions
## By default, dungobjs' player ID is 0 (neither of players).
func get_player_id():
    return 0

## By default, dungobj cannot set a tile.
func set_tile(_tile):
    pass
#endregion
