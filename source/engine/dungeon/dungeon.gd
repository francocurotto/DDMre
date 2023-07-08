extends Reference

# preloads
const OpenTile = preload("res://engine/dungeon/tiles/open_tile.gd")
const PathTile = preload("res://engine/dungeon/tiles/path_tile.gd")
const BlockTile = preload("res://engine/dungeon/tiles/block_tile.gd")
var MovePathQueue = load("res://engine/dungeon/path_queue/move_path_queue.gd")
var AttackPathQueue = load("res://engine/dungeon/path_queue/attack_path_queue.gd")

# variables
var grid = []
var move_cost = 1
var tiles setget , get_tiles
var monsters setget , get_monsters
var summons setget , get_summons

func _init():
    for y in Globals.DUNGEON_HEIGHT:
        var row = []
        for x in Globals.DUNGEON_WIDTH:
            row.append(OpenTile.new(y, x))
        grid.append(row)

# setget functions
func set_layout(player1, player2, layout):
    """
    Set the dungeon tiles given a layout array.
    """
    layout.invert() # correction for reverse order in json format
    for y in Globals.DUNGEON_HEIGHT:
        for x in Globals.DUNGEON_WIDTH:
            grid[y][x] = create_tile(player1, player2, layout[y][x], y, x)

func get_tile(pos):
    """
    Returns the tile at postion pos.
    """
    return grid[pos.y][pos.x]

func get_tiles():
    """
    Get an 1D array of tiles.
    """
    var tiles_array = []
    for row in grid:
        tiles_array += row
    return tiles_array

func get_monsters():
    """
    Get all monsters in dungeon.
    """
    #GODOT4: use array filter
    #GODOT4: remove self
    var monsters_array = []
    for tile in self.tiles:
        if tile.content.is_monster():
            monsters_array.append(tile.content)
    return monsters_array

func get_summons():
    """
    Get all summons in dungeon.
    """
    #GODOT4: use array filter
    #GODOT4: remove self
    var summons_array = []
    for tile in self.tiles:
        if tile.content.is_summon():
            summons_array.append(tile.content)
    return summons_array

func get_max_move_tiles(monster):
    """
    Computes the maximum number of tiles a monster can move. 
    It takes into account:
    - number of move crests
    - monster speed possibly modified by abilities
    - monster maximum movement tiles possibly modified by abilities
    - dungeon move cost possibly modified by item abilities
    """
    var move_crests = monster.player.crestpool.movement
    return min(floor(move_crests/move_cost*monster.speed), monster.max_move)

func get_move_cost(path, monster):
    """
    Get movement cost of monster moving through path. It takes into account:
    - path length
    - monster speed possibly modified by abilities
    - dungeon move cost possibly modified by item abilities
    """
    var move_tiles = len(path)-1 
    return ceil(move_tiles/monster.speed*move_cost)

func get_neighbours_tiles(tile):
    """
    Get neighbours tiles to tile.
    """
    #GODOT4: change to vector2i
    var deltas = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
    var neighbours_tiles = []
    for delta in deltas:
        var new_pos = tile.pos + delta
        if pos_within_dungeon(new_pos):
            neighbours_tiles.append(get_tile(new_pos))
    return neighbours_tiles

func get_move_tiles(monster):
    var move_path_queue = MovePathQueue.new(self, monster)
    return move_path_queue.tiles

func get_move_path(monster, dest):
    var move_path_queue = MovePathQueue.new(self, monster)
    return move_path_queue.get_path(dest)

func get_attack_tiles(monster):
    var attack_path_queue = AttackPathQueue.new(self, monster)
    return attack_path_queue.tiles

func get_vortex_tiles():
    """
    Get all tiles where a vortex is activated.
    """
    #GODOT4: use array filter
    var vortex_tiles = []
    for tile in self.tiles:
        if tile.vortex:
            vortex_tiles.append(tile)
    return vortex_tiles
  
# public functions
func place_path_tile(player, pos):
    """
    Place path tile for player at postion pos.
    """
    grid[pos.y][pos.x] = player.create_tile(pos.y, pos.x)

func place_open_tile(pos):
    """
    Place empty tile at position pos.
    """
    grid[pos.y][pos.x] = OpenTile.new(pos.y, pos.x)

func place_summon(player, pos, diceidx):
    """
    Summon card with index diceidx and place it in dungeon.
    """
    var summon = player.summon_card(diceidx)
    get_tile(pos).set_content(summon)
    summon.initialize_abilities(self)
    return summon

func place_vortex(pos):
    """
    Place a vortex in position pos.
    """
    get_tile(pos).vortex = true

func dimension(player, net, diceidx):
    """
    Dimension net for player and summon card on center of net.
    """
    # place the net
    for pos in net.poslist:
        place_path_tile(player, pos)
    # place summon
    var summon = place_summon(player, net.centerpos, diceidx)
    return summon

# private functions
func create_tile(player1, player2, chr, y, x):
    """
    Create the appropiate tile given the character from the dungeon json.
    """
    match chr:
        "O" : return OpenTile.new(y, x)
        "l" : return player1.create_ml_tile(y, x)
        "L" : return player2.create_ml_tile(y, x)
        "p" : return player1.create_tile(y, x)
        "P" : return player2.create_tile(y, x)
        "N" : return PathTile.new(y, x)
        "X" : return BlockTile.new(y, x)

# is functions
func pos_within_dungeon(pos):
    """
    Check if position is within dungeon limits.
    """
    var y_ok = 0 <= pos.y and pos.y <= Globals.DUNGEON_HEIGHT-1
    var x_ok = 0 <= pos.x and pos.x <= Globals.DUNGEON_WIDTH-1
    return y_ok and x_ok

func can_dimension(net, player):
    """
    Check if it is possible to dimension net. Return true if dimension
    is possible.
    """
    return net_inbound(net) and not net_overlaps(net) and net_connects(net, player)

func net_inbound(net):
    """
    Return true if net is inbound of dungeon.
    """
    #GODOT4: use array all
    for pos in net.poslist:
        if not pos_within_dungeon(pos):
            return false
    return true

func net_overlaps(net):
    """
    Return true if net overlaps current path in dungeon.
    """
    #GODOT4: use array all
    for pos in net.poslist:
        if not get_tile(pos).is_open():
            return true
    return false

func net_connects(net, player):
    """
    Return true if net connects player path.
    """
    for pos in net.poslist:
        for tile in get_neighbours_tiles(get_tile(pos)):
            if tile.is_player_path() and tile.player == player:
                return true
    return false
