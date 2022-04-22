extends Reference

const EmptyTile = preload("res://engine/dungeon/tiles/empty_tile.gd")
const PathTile = preload("res://engine/dungeon/tiles/path_tile.gd")
const BlockTile = preload("res://engine/dungeon/tiles/block_tile.gd")

var array = []

func _init(engine):
    var jsondung = read_jsondung()
    for strrow in jsondung["DUNGEON"]:
        var row = []
        for chr in strrow:
            row.append(create_tile(engine, chr))
        array.append(row)

func create_tile(engine, chr):
    """
    Create the appropiate tile given the character from the dungeon json.
    """
    match chr:
        "O":
            return EmptyTile.new()
        "l":
            return PathTile.new(engine.player1)
        "L":
            return PathTile.new(engine.player2)
        "p":
            return PathTile.new(engine.player1)
        "P":
            return PathTile.new(engine.player2)
        "X":
            return BlockTile.new()

func read_jsondung():
    """
    Reads the json that defines the dungeon.
    """
    var file = File.new()
    file.open(Globals.DUNGPATH, File.READ)
    var jsondung = parse_json(file.get_as_text())
    file.close()
    return jsondung
