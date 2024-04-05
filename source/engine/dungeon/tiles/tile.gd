extends RefCounted
## A single tile that when arranged with others in a grid creates the dungeon.
##
## The tile can be open, a path, or a block, and can hold a single summon or
## monster lord as content. It can also contain a vortex and it has a defined 
## position in the dungeon.

#region preloads
const Noneobj = preload("res://engine/dungobj/noneobj.gd")
#endregion

#region variables
var pos ## Position in dungeon
var vortex = false: get = get_vortex, set = set_vortex ## Vortex existence
var content : get = get_content, set = set_content ## Content located in tile
var player_id : get = get_player_id ## ID of player owner of tile
#endregion

#region builtin functions
func _init(y, x):
    pos = Vector2i(x, y)
    content = Noneobj.new()
#endregion

# public functions
## Compute the L1-distance between this tile and another tile. Tile type does
## not have an effect in the computation.
func tile_range(tile):
    var x_range = abs(pos.x-tile.pos.x)
    var y_range = abs(pos.y-tile.pos.y)
    var range_dist = x_range + y_range
    return range_dist

#region is functions
## By default, tiles are not open
func is_open():
    return false

## By default, tiles are not path
func is_path():
    return false

## By default, tiles are not player path
func is_player_path():
    return false

## By default, tiles are not block
func is_block():
    return false

## By default, tiles are not empty
func is_empty():
    return false

## By default, tiles are not reachable
func is_reachable():
    return false

## By default, tiles are not passable
func is_passable_by(_monster):
    return false
#endregion

#region private functions
## By default, vortex cannot be set on tiles
func set_vortex(_bool):
    pass

## By default, tiles have no vortex
func get_vortex():
    return false

## By default, content cannot be set on a tile
func set_content(_dungobj):
    pass

## By default, tiles have Noneobj as content
func get_content():
    return Noneobj.new()

## By default, player id is 0 (neither of players)
func get_player_id():
    return 0
#endregion
