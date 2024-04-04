extends RefCounted
## A collection of contiguous positions that represents the unfolding of a dice 
## during dimension.
##
## A net is used to determine the positions of path tiles during dimension. It
## can be moved, rotated, fliped, and it tracks it center position, where the
## summon of the dimension will be located.

#region variables
var positions ## net positions
var center : ## net center position
     get: return positions[0]
var unfolds : get = get_unfolds ## unfold directions
#endregion

#region public function
## Add an [param offset] to all positions in net.
func add_offset(offset):
    positions = positions.map(func(pos): return pos + offset)

## Apply all transformations in array [param transformations] to net.
func apply_trans_list(transformations):
    for trans in transformations:
        apply_trans(trans)
#endregion

#region private functions
## Get the directions (vectors) a dice unfolds to create the net. Each
## direction represents the edge a tile "appears" from a previously set tile.
func get_unfolds():
    var _unfolds = []
    for i in range(1, len(positions)):
        var pos = positions[i]
        for prev_pos in positions.slice(0, i):
            var direction = pos - prev_pos
            if direction.length() <= 1:
                _unfolds.append(direction)
                break
    return _unfolds

## Apply transformation [param trans] to the net. It can be one of the
## following transformations:
## - TCW: turn clockwise
## - TAW: turn anti-clockwise
## - FUD: flip up-down
## - FLR: flip left-right
func apply_trans(trans):
    match trans:
        "TCW" : positions = positions.map(apply_turn_clockwise)
        "TAW" : positions = positions.map(apply_turn_anti_clockwise)
        "FUD" : positions = positions.map(apply_flip_up_down)
        "FLR" : positions = positions.map(apply_flip_left_right)

## Turn a position [param pos] 90° in a clockwise direction around the net 
## center position.
func apply_turn_clockwise(pos):
    var x = center.x + (pos.y - center.y) # mathemagics
    var y = center.y - (pos.x - center.x) # mathemagics
    return Vector2i(x, y)

## Turn a position [param pos] 90° in an anti clockwise direction around the 
## net center position.
func apply_turn_anti_clockwise(pos):
    var x = center.x - (pos.y - center.y) # mathemagics
    var y = center.y + (pos.x - center.x) # mathemagics
    return Vector2i(x, y)

## Flip a position [param pos] vertical location around the net center 
## position. 
func apply_flip_up_down(pos):
    var y = 2*center.y - pos.y # mathemagics
    return Vector2i(pos.x, y)

## Flip a position [param pos] horizontal location around the net center 
## position. 
func apply_flip_left_right(pos):
    var x = 2*center.x - pos.x # mathemagics
    return Vector2i(x, pos.y)
#endregion
