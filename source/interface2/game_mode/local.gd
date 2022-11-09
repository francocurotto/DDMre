extends MarginContainer

# preloads
const Engine = preload("res://engine/engine.gd")

# variables
var engine
var player_gui setget , get_player_gui
var opponent_gui setget , get_opponent_gui

# onready variables
onready var p1gui = $P1GUI
#onready var p2gui = $P2GUI

func _ready():
    randomize()
    engine = Engine.new()
    set_guis()
    # connections
    Events.connect("duel_update", self, "on_duel_update")
    Events.connect("dice_rolled", self, "on_dice_rolled")
    Events.connect("card_summoned", self, "on_card_summoned")
    Events.connect("state_update", self, "on_state_update")
    Events.connect("next_turn", self, "on_next_turn")
    Events.connect("player_lost", self, "on_player_lost")

# setget functions
func set_guis():
    p1gui.set_duel(engine, engine.player1, engine.player2)
    #p2gui.set_duel(engine, engine.player2, engine.player1)

func get_player_gui():
    return get_children()[engine.state.player.id-1]

func get_opponent_gui():
    return get_children()[engine.state.opponent.id-1]
