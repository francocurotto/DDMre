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
    for _i in range(HEIGHT):
        var row = []
        for _j in range(WIDTH):
            row.append(EmptyTile.new())
        array.append(row)

# public functions
func set_layout(engine, layout):
    for i in range(len(array)):
        var row = array[i]
        var layrow = layout[len(array)-i-1]
        for j in range(len(row)):
            array[i][j] = create_tile(engine, layrow[j])

func place_dungobj(pos, dungobj):
    array[pos[0]][pos[1]].content = dungobj

# private functions
func create_tile(engine, chr):
    """
    Create the appropiate tile given the character from the dungeon json.
    """
    match chr:
        "O": return EmptyTile.new()
        "l": return engine.player1.create_ml_tile()
        "L": return engine.player2.create_ml_tile()
        "p": return engine.player1.create_tile()
        "P": return engine.player2.create_tile()
        "X": return BlockTile.new()
