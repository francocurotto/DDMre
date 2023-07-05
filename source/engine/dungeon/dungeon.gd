extends Reference

# preloads
const EmptyTile = preload("res://engine/dungeon/tiles/empty_tile.gd")
const PathTile = preload("res://engine/dungeon/tiles/path_tile.gd")
const BlockTile = preload("res://engine/dungeon/tiles/block_tile.gd")

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
            row.append(EmptyTile.new(y, x))
        grid.append(row)

# setget functions
func set_layout(player1, player2, layout):
    """
    Set the dungeon tiles given a layout array.
    """
    layout.invert() # correct for reverse order in json format
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
    - monster maximum movement crests possibly modified by abilities
    - dungeon move cost possibly modified by item abilities
    """
    var move_crests = monster.player.crestpool.movement
    return min(int(move_crests/move_cost)*monster.speed, monster.max_move)

func get_move_tiles(monster):
    var move_path_queue = MovePathQueue.new(self, monster)
    return move_path_queue.tiles
    #var move_path_queue = get_path_queue(MovePath, monster, max_length)
    #return move_path_queue.keys()

func get_move_path(monster, dest):
    var move_path_queue = PathQueue.new(self, monster, MovePath)
    return move_path_queue.get_path(dest)

func get_attack_tiles(monster):
    var attack_path_queue = AttackPathQueue.new(self, monster)
    return attack_path_queue.tiles

#func get_path_queue(PathScript, monster, max_length):
#    var init_path = PathScript.new(monster)
#    var path_queue = {init_path.dest : init_path}
#    for dest in path_queue:
#        var path = path_queue[dest]
#        if path.length >= max_length or not path.is_passable():
#            continue
#        var new_paths = path.get_extended_paths(self)
#        for new_path in new_paths:
#            if new_path.dest in path_queue:
#                path_queue[new_path.dest] = new_path

#func get_move_poss(player, init_pos):
#    """
#    Get all the posible positions a monster at position initpos could reach or
#    pass through with all the available movement crests from player 
#    (includes non-passable positions like items and non-reachable positions 
#    like over flying monsters).
#    """
#    # init variables
#    var monster = get_tile(init_pos).content
#
#    # needed variables
#    var pos_list = [init_pos]
#    var pos_queue = []
#    var move_crests = player.crestpool.movement
#    var max_tiles = get_max_tiles(move_crests, monster)
#
#    # init queue, use dictionary to mix positions and move counter
#    pos_queue.append({pos=init_pos,count=0})
#
#    # iterations
#    while not pos_queue.empty():
#        # get move item information
#        var pos_item = pos_queue.pop_front()
#        var pos = pos_item.pos
#        var count = pos_item.count
#        # if count for next pos will surpass move crest, skip pos
#        var new_count = count + 1
#        if new_count > max_tiles:
#            continue
#        # check if tile is passable or is initial position
#        if get_tile(pos).is_passable(monster) or pos==init_pos:
#            # get next passable positions
#            var move_poss = get_move_neighbours_poss(pos, monster)
#            # check to add next positions to poslist
#            for move_pos in move_poss:
#                # check if new position not visited
#                if not pos_list.has(move_pos):
#                    pos_list.append(move_pos)
#                    pos_queue.append({pos=move_pos, count=new_count})
#    # remove initial position
#    pos_list.pop_front()
#    return pos_list
#
#func get_move_path(pos1, pos2):
#    """
#    Find the shortest path from pos1 to pos2 in the dungeon.
#    """
#    # init data
#    var path_queue = [[pos1]]
#    var visited = []
#    var monster = get_tile(pos1).content
#
#    # iterations
#    while not path_queue.empty():
#        # get curent path
#        var path = path_queue.pop_front()
#        # check for getting to destination
#        var last_pos = path[-1]
#        if last_pos == pos2:
#            return path
#        visited.append(last_pos)
#        # check if tile is passable or is initial position
#        if get_tile(last_pos).is_passable(monster) or last_pos==pos1:
#            # expand path with neighbours and add to queue
#            var pass_poss = get_move_neighbours_poss(last_pos, monster)
#            for pass_pos in pass_poss:
#                if not visited.has(pass_pos):
#                    path_queue.append(path+[pass_pos])
#     # case not path found
#    return []
#
#func get_attack_poss(init_pos):
#    """
#    Get all the posible positions a monster at position init_pos could attack
#    given the available attack crests.
#    """
#    # init variables
#    var monster = get_tile(init_pos).content
#
#    # needed varaibles
#    var pos_list = [init_pos]
#    var pos_queue = []
#    var max_distance = monster.attack_distance
#
#    # init queue, use dictionary to mix positions and move counter
#    pos_queue.append({pos=init_pos,count=0})
#
#    # iterations
#    while not pos_queue.empty():
#        # get move item information
#        var pos_item = pos_queue.pop_front()
#        var pos = pos_item.pos
#        var count = pos_item.count
#        # if count for next pos will surpass move crest, skip pos
#        var new_count = count + 1
#        if new_count > max_distance:
#            continue
#        # check if tile is passable or is initial position
#        if get_tile(pos).is_path() or pos==init_pos:
#            # get next passable positions
#            var attack_poss = get_attack_neighbours_poss(pos)
#            # check to add next positions to poslist
#            for attack_pos in attack_poss:
#                # check if new position not visited
#                if not pos_list.has(attack_pos):
#                    pos_list.append(attack_pos)
#                    pos_queue.append({pos=attack_pos, count=new_count})
#    # remove initial position
#    pos_list.pop_front()
#    return pos_list

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
    grid[pos.y][pos.x] = player.create_tile(pos.y, pos.x)

func place_empty_tile(pos):
    """
    Place empty tile at position pos.
    """
    grid[pos.y][pos.x] = EmptyTile.new(pos.y, pos.x)

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

func can_dimension(net, player):
    """
    Check if it is possible to dimension net. Return true if dimension
    is possible.
    """
    return net_inbound(net) and net_not_overlaps(net) and net_connects(net, player)

# signals callback
func on_summon_destroyed(summon):
    """
    When a summon is destroyed (monster is killed or dimension item is 
    activated), remove summon from dungeon.
    """
    summon.tile.empty_tile()

# private functions
func create_tile(player1, player2, chr, y, x):
    """
    Create the appropiate tile given the character from the dungeon json.
    """
    match chr:
        "O" : return EmptyTile.new(y, x)
        "l" : return player1.create_ml_tile(y, x)
        "L" : return player2.create_ml_tile(y, x)
        "p" : return player1.create_tile(y, x)
        "P" : return player2.create_tile(y, x)
        "N" : return PathTile.new(y, x)
        "X" : return BlockTile.new(y, x)

#func get_move_neighbours_poss(pos, monster):
#    """
#    Get neighbours positions to pos that are passable tiles for monster.
#    """
#    var neig_poss = get_neighbours_poss(pos)
#    var pass_poss = []
#    for neig_pos in neig_poss:
#        var tile = get_tile(neig_pos)
#        if tile.is_reachable() or tile.is_passable(monster):
#            pass_poss.append(neig_pos)
#    return pass_poss
#
#func get_attack_neighbours_poss(pos):
#    """
#    Get neighbours positions to pos where an attack can pass through.
#    """
#    var neig_poss = get_neighbours_poss(pos)
#    var pass_poss = []
#    for neig_pos in neig_poss:
#        var tile = get_tile(neig_pos)
#        if tile.is_path():
#            pass_poss.append(neig_pos)
#    return pass_poss
#
#func get_neighbours_poss(pos):
#    """
#    Get neighbours positions to pos.
#    """
#    var deltas = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
#    var neigposs = []
#    for delta in deltas:
#        var newpos = pos + delta
#        if pos_within_dungeon(newpos):
#            neigposs.append(newpos)
#    return neigposs

func pos_within_dungeon(pos):
    """
    Check if position is within dungeon limits.
    """
    var y_ok = 0 <= pos.y and pos.y <= Globals.DUNGEON_HEIGHT-1
    var x_ok = 0 <= pos.x and pos.x <= Globals.DUNGEON_WIDTH-1
    return y_ok and x_ok

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
            if tile.is_player_path() and tile.player == player:
                return true
    return false
