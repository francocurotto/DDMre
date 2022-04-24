tool
extends VBoxContainer

export (String) var layout = "default" setget set_dungeon

func set_dungeon(_layout):
    layout = _layout
    #Globals.dungpath = "res://dungeon/" + layout + ".json" 
    var Engine = load("res://engine/engine.gd")
    var engine = Engine.new()
    set_tiles(engine.dungeon)

func set_tiles(edungeon):
    for i in range(get_child_count()):
        var row = get_child(i)
        var erow = edungeon.array[i]
        for j in range(row.get_child_count()):
            var tile = row.get_child(j)
            var etile = erow[j]
            tile.set_tile(etile)
