extends Reference

# preloads
const EmptyTile = preload("res://engine/dungeon/tiles/empty_tile.gd")
const BlockTile = preload("res://engine/dungeon/tiles/block_tile.gd")

# constants
const HEIGHT = 19
const WIDTH = 13

# variables
var array = []

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

func get_dungobj_pos(dungobj):
    """
    Finds the position of a dungobj in the dungeon.
    """
    for row in array:
        for tile in row:
            if tile.content == dungobj:
                return tile.pos

func get_moveposs(player, initpos):
    """
    Get all the posible positions a monster at position initpos could move
    with all the available movement crests from player.
    """
    # init variables
    var monster = get_tile(initpos).content
    
    # needed varaibles
    var poslist = [initpos]
    var movequeue = []
    var movecrests = player.crestpool.slots["MOVEMENT"]

    # init queue, use dictionary to mix positions and move counter
    movequeue.append({pos=initpos,count=0})

    # iterations
    while not movequeue.empty():
        # get move item information
        var moveitem = movequeue.pop_front()
        var pos = moveitem.pos
        var count = moveitem.count
        # if count for next pos will surpass move crest, skip pos
        var newcount = count + 1
        if newcount > movecrests:
            continue
        # check if tile is passable or is initial position
        if get_tile(pos).is_passable(monster) or pos==initpos:
            # get next reachable positions
            var reachposs = get_reachable_neighbours_poss(pos)
            # check to add next positions to poslist
            for reachpos in reachposs:
                # check if new position not visited
                if not poslist.has(reachpos):
                    poslist.append(reachpos)
                    movequeue.append({pos=reachpos, count=newcount})
    # remove initial position
    poslist.pop_front()
    return poslist

func get_attackposs(player, pos):
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
    var targetposs = get_neighbours_poss(pos)
    var attackposs = []
    for targetpos in targetposs:
        if get_tile(targetpos).is_path():
            attackposs.append(targetpos)
    return attackposs

func get_movepath(pos1, pos2):
    """
    Find the shortest path from pos1 to pos2 in the dungeon.
    """
    # init data
    var pathqueue = [[pos1]]
    var visited = []
    var monster = get_tile(pos1).content

    # iterations
    while not pathqueue.empty():
        # get curent path
        var path = pathqueue.pop_front()
        # check for getting to destination
        var lastpos = path[-1]
        if lastpos == pos2:
            return path
        visited.append(lastpos)
        # check if tile is passable or is initial position
        if get_tile(lastpos).is_passable(monster) or lastpos==pos1:
            # expand path with neighbours and add to queue
            var reachposs = get_reachable_neighbours_poss(lastpos)
            for reachpos in reachposs:
                if not visited.has(reachpos):
                    pathqueue.append(path+[reachpos])
     # case not path found
    return []

# public functions
func place_path_tile(player, pos):
    """
    Place path tile for player at postion pos.
    """
    array[pos.y][pos.x] = player.create_tile(pos.y, pos.x)

func place_dungobj(pos, dungobj):
    """
    Place a dungobj in the dungeon at position pos.
    """
    array[pos.y][pos.x].content = dungobj

func dimension(player, net, diceidx):
    """
    Dimension net for player and summon card on center of net.
    """
    # add the net
    for pos in net.poslist:
        place_path_tile(player, pos)
    var summon = player.summon_card(diceidx)
    place_dungobj(net.centerpos, summon)

func can_dimension(net, player):
    """
    Check if it is possible to dimension net. Return true if dimension
    is possible.
    """
    return net_inbound(net) and net_not_overlaps(net) and net_connects(net, player)

# signals callback
func on_monster_death(monster):
    """
    When a monster dies, remove monster from dungeon.
    """
    var pos = get_dungobj_pos(monster)
    get_tile(pos).empty_tile()

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

func get_reachable_neighbours_poss(pos):
    """
    Get neighbours positions to pos that are reachable tiles.
    """
    var neigposs = get_neighbours_poss(pos)
    var reachposs = []
    for neigpos in neigposs:
        if get_tile(neigpos).is_reachable():
            reachposs.append(neigpos)
    return reachposs

func get_target_neighbours_poss(pos):
    """
    Get neighbours positions to pos that have a target in that tile.
    """
    var neigposs = get_neighbours_poss(pos)
    var targetposs = []
    for neigpos in neigposs:
        if get_tile(neigpos).content.is_target():
            targetposs.append(neigpos)
    return targetposs

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
