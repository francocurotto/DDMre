tool
extends AspectRatioContainer

export (String, "default", "test") var layout = "test" setget set_layout
export (int, 1, 2) var playerid = 1 setget set_playerid

var dungeon
var player

signal mouse_entered_dungobj(dungobj)
signal mouse_exited_dungobj(dungobj)

func _ready():
    for row in $Cols.get_children():
        for t in row.get_children():
            t.connect("mouse_entered_dungobj", self, "on_mouse_entered_dungobj")
            t.connect("mouse_exited_dungobj", self, "on_mouse_exited_dungobj")
    if Engine.editor_hint:
        set_dungeon_tool(layout, playerid)

func set_dungeon(_dungeon, _player):
    dungeon = _dungeon
    player = _player
    update_dungeon()

func update_dungeon():
    for i in range($Cols.get_child_count()):
        var row = dungeon.array[i]
        if player.id == 1: i = $Cols.get_child_count()-1-i # v-flip dungeon for player1
        var irow = $Cols.get_child(i)
        for j in range(irow.get_child_count()):
            var tile = row[j]
            var itile = irow.get_child(j)
            itile.set_tile(tile)

func on_mouse_entered_dungobj(dungobj):
    emit_signal("mouse_entered_dungobj", dungobj)

func on_mouse_exited_dungobj():
    emit_signal("mouse_exited_dungobj")
            
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
