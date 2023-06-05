extends MarginContainer

# preloads
const Engine = preload("res://engine/engine.gd")

# variables
var engine
var player_gui setget , get_player_gui
var opponent_gui setget , get_opponent_gui

# onready variables
onready var p1gui = $P1GUI
onready var p2gui = $P2GUI

func _ready():
    randomize()
    engine = Engine.new()
    set_guis()
    # connections
    Events.connect("dice_rolled", self, "on_dice_rolled")
    Events.connect("state_update", self, "on_state_update")
    Events.connect("player_lost", self, "on_player_lost")
    # run first state update
    on_state_update(engine.state.NAME)

# setget functions
func set_guis():
    p1gui.set_duel(engine, engine.player1, engine.player2)
    p2gui.set_duel(engine, engine.player2, engine.player1)

func get_player_gui():
    return get_children()[engine.state.player.id-1]

func get_opponent_gui():
    return get_children()[engine.state.opponent.id-1]

func set_player_gui():
    self.player_gui.visible = true
    self.opponent_gui.visible = false

# signals callbacks
func on_state_update(state_name):
    set_player_gui()
    match state_name:
        "ROLL"        : on_state_update_roll()
        "DIMENSION"   : on_state_update_dimension()
        "DUNGEON"     : on_state_update_dungeon()
        "REPLY"       : on_state_update_reply()
        "DIMABILITY"  : on_state_update_ability()
        "ITEMABILITY" : on_state_update_ability()

func on_state_update_roll():
    self.player_gui.on_state_update_roll()

func on_state_update_dimension():
    self.player_gui.on_state_update_dimension()

func on_state_update_dungeon():
    self.player_gui.on_state_update_dungeon()

func on_state_update_reply():
    self.player_gui.on_state_update_reply()

func on_state_update_ability():
    self.player_gui.on_state_update_dim_ability()

func on_dice_rolled(sides):
    self.player_gui.set_roll(sides)

func on_player_lost(_player):
    get_tree().quit()
