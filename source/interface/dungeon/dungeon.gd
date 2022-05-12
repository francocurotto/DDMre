tool
extends VBoxContainer

export (String, "default", "test") var layout = "default" setget set_layout
export (int, 1, 2) var player = 1 setget set_player

func _ready():
    if Engine.editor_hint:
        set_dungeon_tool(layout, player)

func set_dungeon(dungeon, playerid):
    for i in range(get_child_count()):
        var row = dungeon.array[i]
        if playerid == 1: i = get_child_count()-1-i # v-flip dungeon for player1
        var irow = get_child(i)
        for j in range(irow.get_child_count()):
            var tile = row[j]
            var itile = irow.get_child(j)
            itile.set_tile(tile)
            
func set_dungeon_tool(_layout, _player):
    var Engine = load("res://engine/engine.gd")
    var engine = Engine.new("res://dungeons/" + _layout + ".json")
    set_dungeon(engine.dungeon, _player)

func set_layout(_layout):
    layout = _layout
    set_dungeon_tool(layout, player)

func set_player(_player):
    player = _player
    set_dungeon_tool(layout, player)
