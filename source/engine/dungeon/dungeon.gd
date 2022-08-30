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
    
    # init queue, use dictionary to mix positions and move counter
    movequeue.append({pos=initpos,count=0})
    
    # iteration
    var i = 0
    while not movequeue.empty():
        print(i); i+=1
        # get move item information
        var moveitem = movequeue.pop_front()
        var pos = moveitem.pos
        var count = moveitem.count
        # if move crests are surpassed skip pos
        if count+1 > movecrests:
            continue
        # check if tile is passable
        var tile = array[pos.y][pos.x]
        if count==0 or (tile.is_path() and not tile.is_occupied()):
            # get next reachable positions
            var reachposs = get_reachable_neighbours_poss(pos)
            # check to add next positions to poslist
            for reachpos in reachposs:
                if not poslist.has(reachpos):
                    poslist.append(reachpos)
                    movequeue.append({pos=reachpos, count=count+1})
    # remove initial position
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
    return 0 <= pos.y and pos.y <= HEIGHT and 0 <= pos.x and pos.x <= WIDTH
