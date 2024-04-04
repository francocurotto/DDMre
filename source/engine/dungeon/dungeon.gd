extends RefCounted
## Dungeon where dice are dimensioned and summons interact.
##
## The dungeon is a grid of empty tiles, that is filled with path tiles when
## the player dimension dice. Monsters move through the dungeon to advance the
## game state.

#region preloads
const OpenTile = preload("res://engine/dungeon/tiles/open_tile.gd")
const NeutralPathTile = preload("res://engine/dungeon/tiles/neutral_path_tile.gd")
const BlockTile = preload("res://engine/dungeon/tiles/block_tile.gd")
const MovePathQueue = preload("res://engine/dungeon/path_queue/move_path_queue.gd")
const AttackPathQueue = preload("res://engine/dungeon/path_queue/attack_path_queue.gd")
#endregion

#region variables
var grid = [] ## 2D array of tiles that compose the dungeon
var move_cost = 1 ## Number of crests required for a monster to move one tile
var tiles : get = get_tiles ## 1D array of all tiles
var monsters : get = get_monsters ## Array of all monsters in dungeon
var summons : get = get_summons ## Array of all summons in dungeon
#endregion

#region builtin functions
func _init():
    for y in Globals.DUNGEON_HEIGHT:
        var row = []
        for x in Globals.DUNGEON_WIDTH:
            row.append(OpenTile.new(y, x))
        grid.append(row)
#endregion

#region public functions
## Set the dungeon tiles given a [param layout] array. Uses [param player1],
## and [param player2] for tile generation.
func set_layout(player1, player2, layout):
    layout.reverse() # correction for reverse order in json format
    for y in Globals.DUNGEON_HEIGHT:
        for x in Globals.DUNGEON_WIDTH:
            grid[y][x] = create_tile(player1, player2, layout[y][x], y, x)

## Returns the tile at postion [param pos].
func get_tile(pos):
    return grid[pos.y][pos.x]

## Computes the maximum number of tiles a [param monster] can move. 
## It takes into account:
## - number of move crests
## - monster speed possibly modified by abilities
## - monster maximum movement tiles possibly modified by abilities
## - dungeon move cost possibly modified by item abilities
func get_max_move_tiles(monster):
    var move_crests = monster.player.crestpool.movement
    return min(floor(move_crests/move_cost*monster.speed), monster.max_move)

## Get the movement cost of a [param monster] moving through a [param path]. 
## It takes into account:
## - path length
## - monster speed possibly modified by abilities
## - dungeon move cost possibly modified by item abilities
func get_move_cost(path, monster):
    var move_tiles = len(path)-1 
    return ceil(move_tiles/monster.speed*move_cost)

## Get neighbours tiles of a [param tile].
func get_neighbours_tiles(tile):
    var deltas = [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN]
    var neighbours_tiles = []
    for delta in deltas:
        var new_pos = tile.pos + delta
        if pos_within_dungeon(new_pos):
            neighbours_tiles.append(get_tile(new_pos))
    return neighbours_tiles

## Get all possible tiles a [param monster] can move in the dungeon.
func get_move_tiles(monster):
    var move_path_queue = MovePathQueue.new(self, monster)
    return move_path_queue.tiles

## Get an array of tiles corresponding the path a [param monster] can take to
## reach tile [param dest].
func get_move_path(monster, dest):
    var move_path_queue = MovePathQueue.new(self, monster)
    return move_path_queue.get_path(dest)

## Get all possible tiles a [param monster] can attack in the dungeon.
func get_attack_tiles(monster):
    var attack_path_queue = AttackPathQueue.new(self, monster)
    return attack_path_queue.tiles

## Get all tiles where a vortex is activated.
func get_vortex_tiles():
    var vortex_tiles = tiles.filter(func(tile): return tile.vortex)
    return vortex_tiles 
 
## Place path tile for [param player] at postion [param pos].
func place_path_tile(player, pos):
    grid[pos.y][pos.x] = player.create_tile(pos.y, pos.x)

## Place open tile at position [param pos].
func place_open_tile(pos):
    grid[pos.y][pos.x] = OpenTile.new(pos.y, pos.x)

## Summon card with index [param diceidx] of [param player] and place it in 
## dungeon at position [param pos].
func place_summon(player, pos, diceidx):
    var summon = player.summon_card(diceidx)
    get_tile(pos).content = summon
    summon.initialize_abilities(self)
    summon.activate_dim_abilities()
    return summon

## Place a vortex in position [param pos].
func place_vortex(pos):
    get_tile(pos).vortex = true

## Dimension [param net] for [param player] and summon card in index 
## [param diceidx] on center of net.
func dimension(player, net, diceidx):
    # place the net
    for pos in net.positions:
        place_path_tile(player, pos)
    # place summon
    var summon = place_summon(player, net.center, diceidx)
    Events.dice_dimensioned.emit(summon, net)
    return summon
#endregion

#region is functions
## Check if position [param pos] is within dungeon limits.
func pos_within_dungeon(pos):
    var y_ok = 0 <= pos.y and pos.y <= Globals.DUNGEON_HEIGHT-1
    var x_ok = 0 <= pos.x and pos.x <= Globals.DUNGEON_WIDTH-1
    return y_ok and x_ok

## Check if it is possible to dimension [param net] for [param player]. Return 
## true if dimension is possible.
func can_dimension(net, player):
    return net_inbound(net) and not net_overlaps(net) and net_connects(net, player)

## Return true if [param net] is inbound of dungeon.
func net_inbound(net):
    return net.positions.all(pos_within_dungeon)

## Return true if [param net] overlaps current path in dungeon.
func net_overlaps(net):
    return net.positions.any(func(pos): return not get_tile(pos).is_open())

## Return true if [param net] connects player path.
func net_connects(net, player):
    for pos in net.positions:
        for tile in get_neighbours_tiles(get_tile(pos)):
            if tile.is_player_path() and tile.player == player:
                return true
    return false
#endregion

#region private functions
## Get an 1D array of tiles.
func get_tiles():
    var tiles_array = []
    for row in grid:
        tiles_array += row
    return tiles_array

## Get all monsters in dungeon.
func get_monsters():
    var monsters_array = []
    for tile in tiles:
        if tile.content.is_monster():
            monsters_array.append(tile.content)
    return monsters_array

## Get all summons in dungeon.
func get_summons():
    var summons_array = []
    for tile in tiles:
        if tile.content.is_summon():
            summons_array.append(tile.content)
    return summons_array

## Create the appropiate tile given the character from the dungeon json.
func create_tile(player1, player2, chr, y, x):
    match chr:
        "O" : return OpenTile.new(y, x)
        "l" : return player1.create_ml_tile(y, x)
        "L" : return player2.create_ml_tile(y, x)
        "p" : return player1.create_tile(y, x)
        "P" : return player2.create_tile(y, x)
        "N" : return NeutralPathTile.new(y, x)
        "X" : return BlockTile.new(y, x)
#endregion
