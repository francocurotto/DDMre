extends Reference

const EmptyTile = preload("res://engine/dungeon/tiles/empty_tile.gd")
const BlockTile = preload("res://engine/dungeon/tiles/block_tile.gd")

const HEIGHT = 19
const WIDTH = 13 

var array = []

func _init():
    for _i in range(HEIGHT):
        var row = []
        for _j in range(WIDTH):
            row.append(EmptyTile.new())
        array.append(row)

func set_layout(engine, layout):
    for i in range(len(array)):
        var row = array[i]
        var layrow = layout[i]
        for j in range(len(row)):
            row[j] = create_tile(engine, layrow[j])
        array.append(row)

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
