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
    with all the avilable movement crests from player.
    """
    # TODO: implement
    return []

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
