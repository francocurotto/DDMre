tool
extends PanelContainer

const Engine = preload("res://engine/engine.gd")

export (int, 1, 2) var playerid = 1 setget set_playerid
export (String, "default", "test") var layout = "default" setget set_layout

var engine

func _ready():
    randomize()
    engine = Engine.new()
    set_guis()

func set_guis():
    $P1GUI.set_duel(engine.player1, engine.player2, engine.dungeon)
    $P2GUI.set_duel(engine.player2, engine.player1, engine.dungeon)

func set_playerid(_playerid):
    playerid = _playerid
    set_guis()
    $P1GUI.visible = playerid%2
    $P2GUI.visible = (playerid+1)%2

func set_layout(_layout):
    layout = _layout
    engine = Engine.new("res://dungeons/" + layout + ".json")
    set_guis()
    
