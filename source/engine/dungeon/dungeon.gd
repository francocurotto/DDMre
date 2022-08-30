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

# public functions
func set_layout(engine, layout):
    """
    Set the layout of the dungeon given a dictionary.
    """
    for i in range(len(array)):
        var row = array[i]
        var layrow = layout[len(array)-i-1]
        for j in range(len(row)):
            array[i][j] = create_tile(engine, layrow[j], i, j)

func place_dungobj(pos, dungobj):
    """
    Place a dungobj in the dungeon at specified position.
    """
    array[pos[0]][pos[1]].content = dungobj

func get_moveposs(player, initpos):
    """
    Get all the posible positions a monster at position initpos could move
    with all the available movement crests from player.
    """
    # needed varaibles
    var poslist = [initpos]
    var movequeue = []
    var movecrests = player.crestpool.slots["MOVEMENT"]
    
    # init queue
    movequeue.append(MoveCount.new(initpos, 0))
    
    # iteration
    var i = 0
    while not movequeue.empty():
        var currmovecount = movequeue.pop_front()
        var currcount = currmovecount.count
        var currpos = currmovecount.pos
        # if move crests are surpassed skip pos
        if currcount+1 > movecrests:
            continue
        var currtile = array[currpos.y][currpos.x]
        if currcount==0 or (currtile.is_path() and not currtile.is_occupied()):
            var reachposs = get_reachable_neighbours_poss(currpos)
            for reachpos in reachposs:
                if not pos_in_list(poslist, reachpos):
                    poslist.append(reachpos)
                    movequeue.append(MoveCount.new(reachpos, currcount+1))
    poslist.pop_front()
    return poslist

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
        var tile = array[neigpos.y][neigpos.x]
        if tile.is_reachable():
            reachposs.append(neigpos)
    return reachposs

func get_neighbours_poss(pos):
    """
    Get neighbours positions to pos.
    """
    var neigdeltas = [[0,1], [0,-1], [1,0], [-1,0]]
    var neigposs = []
    for neigdelta in neigdeltas:
        var newpos = pos.add_array(neigdelta)
        if pos_within_dungeon(newpos):
            neigposs.append(newpos)
    return neigposs

func pos_within_dungeon(pos):
    """
    Check if position is within dungeon limits.
    """
    return 0 <= pos.y and pos.y <= HEIGHT and 0 <= pos.x and pos.x <= WIDTH

func pos_in_list(list, pos):
    for listpos in list:
        if listpos.y == pos.y and listpos.x == pos.x:
            return true
    return false

class MoveCount:
    var pos
    var count
    func _init(_pos, _count):
        pos = _pos
        count = _count
