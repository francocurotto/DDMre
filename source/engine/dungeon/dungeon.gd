extends Reference

# preloads
const EmptyTile = preload("res://engine/dungeon/tiles/empty_tile.gd")
const BlockTile = preload("res://engine/dungeon/tiles/block_tile.gd")

# constants
const HEIGHT = 19
const WIDTH = 13

# variables
var array = []
var move_cost = 1
var tiles setget , get_tiles
var monsters setget , get_monsters
var summons setget , get_summons

func _init():
    for i in range(HEIGHT):
        var row = []
        for j in range(WIDTH):
            row.append(EmptyTile.new(i, j))
        array.append(row)

# setget functions
func set_layout(engine, layout):
    """
    Set the layout of the dungeon given a dictionary.
    """
    for i in range(len(array)):
        var row = array[i]
        var layrow = layout[len(array)-i-1]
        for j in range(len(row)):
            array[i][j] = create_tile(engine, layrow[j], i, j)

func get_tile(pos):
    """
    Returns the tile at postion pos.
    """
    return array[pos.y][pos.x]

func get_tiles():
    """
    Get an 1D array of tiles.
    """
    var tile_array = []
    for row in array:
        tile_array += row
    return tile_array

func get_monsters():
    """
    Get all monsters in dungeon.
    """
    var monster_array = []
    for tile in self.tiles:
        if tile.content.is_monster():
            monster_array.append(tile.content)
    return monster_array

func get_summons():
    """
    Get all summons in dungeon.
    """
    var summon_array = []
    for tile in self.tiles:
        if tile.content.is_summon():
            summon_array.append(tile.content)
    return summon_array

func get_move_poss(player, init_pos):
    """
    Get all the posible positions a monster at position initpos could reach or
    pass through with all the available movement crests from player 
    (includes non-passable positions like items and non-reachable positions 
    like over flying monsters).
    """
    # init variables
    var monster = get_tile(init_pos).content
    
    # needed varaibles
    var pos_list = [init_pos]
    var move_queue = []
    var move_crests = player.crestpool.slots["MOVEMENT"]
    var max_tiles = get_max_tiles(move_crests, monster)

    # init queue, use dictionary to mix positions and move counter
    move_queue.append({pos=init_pos,count=0})

    # iterations
    while not move_queue.empty():
        # get move item information
        var move_item = move_queue.pop_front()
        var pos = move_item.pos
        var count = move_item.count
        # if count for next pos will surpass move crest, skip pos
        var new_count = count + 1
        if new_count > max_tiles:
            continue
        # check if tile is passable or is initial position
        if get_tile(pos).is_passable(monster) or pos==init_pos:
            # get next passable positions
            var move_poss = get_move_neighbours_poss(pos, monster)
            # check to add next positions to poslist
            for move_pos in move_poss:
                # check if new position not visited
                if not pos_list.has(move_pos):
                    pos_list.append(move_pos)
                    move_queue.append({pos=move_pos, count=new_count})
    # remove initial position
    pos_list.pop_front()
    return pos_list

func get_move_path(pos1, pos2):
    """
    Find the shortest path from pos1 to pos2 in the dungeon.
    """
    # init data
    var path_queue = [[pos1]]
    var visited = []
    var monster = get_tile(pos1).content

    # iterations
    while not path_queue.empty():
        # get curent path
        var path = path_queue.pop_front()
        # check for getting to destination
        var last_pos = path[-1]
        if last_pos == pos2:
            return path
        visited.append(last_pos)
        # check if tile is passable or is initial position
        if get_tile(last_pos).is_passable(monster) or last_pos==pos1:
            # expand path with neighbours and add to queue
            var pass_poss = get_move_neighbours_poss(last_pos, monster)
            for pass_pos in pass_poss:
                if not visited.has(pass_pos):
                    path_queue.append(path+[pass_pos])
     # case not path found
    return []

func get_attack_poss(player, pos):
    """
    Get all the posible positions a monster at position pos could attack
    given the available attack crests.
    """
    # check for available attack crests
    if player.crestpool.slots["ATTACK"] <= 0:
        return []
    # check of monster in cooldown
    if get_tile(pos).content.cooldown:
        return []
   # get target pos and check if are opponent targets
    var neig_poss = get_neighbours_poss(pos)
    var attack_poss = []
    for neig_pos in neig_poss:
        if get_tile(neig_pos).is_path():
            attack_poss.append(neig_pos)
    return attack_poss

func get_vortex_poss():
    """
    Get all positions where a vortex is activated in a tile.
    """
    var vortex_poss = []
    for tile in self.tiles:
        if tile.vortex:
            vortex_poss.append(tile.pos)
    return vortex_poss

func get_move_cost(path, monster):
    """
    Get movement const of monster moving through path. It takes into account:
    - monster speed possibly modified by abilities
    - dungeon move cost possibly modified by item abilities
    """
    return int(monster.get_move_cost(path) * move_cost)

# public functions
func place_path_tile(player, pos):
    """
    Place path tile for player at postion pos.
    """
    array[pos.y][pos.x] = player.create_tile(pos.y, pos.x)

func dimension(player, net, diceidx):
    """
    Dimension net for player and summon card on center of net.
    """
    # add the net
    for pos in net.poslist:
        place_path_tile(player, pos)
    var summon = player.summon_card(diceidx)
    array[net.centerpos.y][net.centerpos.x].set_content(summon)
    summon.initialize_abilities(self)

func can_dimension(net, player):
    """
    Check if it is possible to dimension net. Return true if dimension
    is possible.
    """
    return net_inbound(net) and net_not_overlaps(net) and net_connects(net, player)

# signals callback
func on_summon_dead(summon):
    """
    When a summon dies (monster is killed of item deactivate itself), 
    remove summon from dungeon.
    """
    summon.tile.empty_tile()

# private functions
func create_tile(engine, chr, i, j):
    """
    Create the appropiate tile given the character from the dungeon json.
    """
    match chr:
        "O": return EmptyTile.new(i, j)
        "l": return engine.player1.create_ml_tile(i, j)
        "L": return engine.player2.create_ml_tile(i, j)
        "p": return engine.player1.create_tile(i, j)
        "P": return engine.player2.create_tile(i, j)
        "X": return BlockTile.new(i, j)

func get_move_neighbours_poss(pos, monster):
    """
    Get neighbours positions to pos that are passable tiles for monster.
    """
    var neigposs = get_neighbours_poss(pos)
    var passposs = []
    for neigpos in neigposs:
        var tile = get_tile(neigpos)
        if tile.is_reachable() or tile.is_passable(monster):
            passposs.append(neigpos)
    return passposs

func get_neighbours_poss(pos):
    """
    Get neighbours positions to pos.
    """
    var deltas = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
    var neigposs = []
    for delta in deltas:
        var newpos = pos + delta
        if pos_within_dungeon(newpos):
            neigposs.append(newpos)
    return neigposs

func pos_within_dungeon(pos):
    """
    Check if position is within dungeon limits.
    """
    return 0 <= pos.y and pos.y <= HEIGHT-1 and 0 <= pos.x and pos.x <= WIDTH-1

# private functions
func net_inbound(net):
    """
    Return true if net is inbound of dungeon.
    """
    for pos in net.poslist:
        if not pos_within_dungeon(pos):
            return false
    return true

func net_not_overlaps(net):
    """
    Return true if net does not overlaps current path in dungeon.
    """
    for pos in net.poslist:
        if not get_tile(pos).is_empty():
            return false
    return true

func net_connects(net, player):
    """
    Return true if net connects player path.
    """
    for pos in net.poslist:
        for neig in get_neighbours_poss(pos):
            var tile = get_tile(neig)
            if tile.is_path() and tile.player == player:
                return true
    return false

func get_max_tiles(move_crests, monster):
    """
    Computes the maximum number of tiles a monster can move. 
    It takes into account:
    - number of move crests
    - monster speed possibly modified by abilities
    - monster maximum movement crests possibly modified by abilities
    - dungeon move cost possibly modified by item abilities
    """
    return min(int(monster.get_max_tiles(move_crests) / move_cost), monster.max_move)
