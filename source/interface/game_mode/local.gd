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
    # connections
    # warning-ignore:return_value_discarded
    engine.state.connect("dice_rolled", self, "on_dice_rolled")

func set_guis():
    $P1GUI.set_duel(engine, engine.player1, engine.player2)
    $P2GUI.set_duel(engine, engine.player2, engine.player1) 

func on_dice_rolled(sides, player):
    set_guis()
    var player_gui = get_children()[player.id-1]
    var opponent_gui = get_children()[player.id%2]
    player_gui.set_player_roll(sides)
    opponent_gui.set_opponent_roll(sides)
    
func set_playerid(_playerid):
    engine = Engine.new("res://dungeons/" + layout + ".json")
    playerid = _playerid
    set_guis()
    $P1GUI.visible = playerid%2
    $P2GUI.visible = (playerid+1)%2

func set_layout(_layout):
    layout = _layout
    engine = Engine.new("res://dungeons/" + layout + ".json")
    set_guis()
