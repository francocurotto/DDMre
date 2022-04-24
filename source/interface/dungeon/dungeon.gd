tool
extends VBoxContainer

export (String, "default", "test") var layout = "default" setget set_layout
export (int, 1, 2) var player = 1 setget set_player

func set_dungeon(edungeon, player):
    for i in range(get_child_count()):
        var erow = edungeon.array[i]
        i = i*(player%2) + (get_child_count()-1-i)*((player+1)%2)
        var row = get_child(i)
        for j in range(row.get_child_count()):
            var etile = erow[j]
            var tile = row.get_child(j)
            tile.set_tile(etile)
            
func set_dungeon_standalone(layout, player):
    var Engine = load("res://engine/engine.gd")
    var engine = Engine.new("res://dungeons/" + layout + ".json")
    set_dungeon(engine.dungeon, player)

func set_layout(_layout):
    layout = _layout
    set_dungeon_standalone(layout, player)

func set_player(_player):
    player = _player
    set_dungeon_standalone(layout, player)
