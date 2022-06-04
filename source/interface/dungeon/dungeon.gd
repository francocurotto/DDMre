tool
extends VBoxContainer

export (String, "default", "test") var layout = "default" setget set_layout
export (int, 1, 2) var playerid = 1 setget set_playerid

var dungeon
var player

func _ready():
    if Engine.editor_hint:
        set_dungeon_tool(layout, playerid)

func set_dungeon(_dungeon, _player):
    dungeon = _dungeon
    player = _player
    update_dungeon()

func update_dungeon():
    for i in range(get_child_count()):
        var row = dungeon.array[i]
        if player.id == 1: i = get_child_count()-1-i # v-flip dungeon for player1
        var irow = get_child(i)
        for j in range(irow.get_child_count()):
            var tile = row[j]
            var itile = irow.get_child(j)
            itile.set_tile(tile)
            
func set_dungeon_tool(_layout, _playerid):
    var Engine = load("res://engine/engine.gd")
    var engine = Engine.new("res://dungeons/" + _layout + ".json")
    dungeon = engine.dungeon
    player = [engine.player1, engine.player2][_playerid-1]
    update_dungeon()

func set_layout(_layout):
    layout = _layout
    set_dungeon_tool(layout, playerid)

func set_playerid(_playerid):
    playerid = _playerid
    set_dungeon_tool(layout, playerid)
