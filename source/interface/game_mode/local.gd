extends MarginContainer

# preloads
const Engine = preload("res://engine/engine.gd")

# variables
var engine
var player_gui = 1 setget , get_player_gui
var opponent_gui setget , get_opponent_gui

# onready variables
onready var p1gui = $P1GUI
onready var p2gui = $P2GUI

func _ready():
    randomize()
    engine = Engine.new()
    set_guis()
    # connections
    engine.connect("state_update", self, "on_state_update")
    engine.connect("duel_update", self, "on_duel_update")
    engine.connect("next_turn", self, "on_next_turn")
    engine.connect("player_lost", self, "on_player_lost")
    Events.connect("dice_rolled", self, "on_dice_rolled")
    Events.connect("dice_dimensioned", self, "on_dice_dimensioned")
    # run first state update
    on_state_update(engine.state.NAME)
    on_next_turn(1)

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
    p1gui.on_state_update(state_name)
    p2gui.on_state_update(state_name)
    match state_name:
        "ROLL"      : on_state_update_roll()
        "DIMENSION" : on_state_update_dimension()
        "DUNGEON"   : on_state_update_dungeon()
        "REPLY"     : on_state_update_reply()

func on_state_update_roll():
    self.player_gui.on_state_update_roll()

func on_state_update_dimension():
    set_player_gui()
    self.player_gui.on_state_update_dimension()

func on_state_update_dungeon():
    set_player_gui()
    self.player_gui.on_state_update_dungeon()

func on_state_update_reply():
    set_player_gui()
    self.player_gui.on_state_update_reply()

func on_duel_update(_cmdname):
    p1gui.update_gui()
    p2gui.update_gui()

func on_next_turn(turn):
    set_player_gui()
    p1gui.on_next_turn(turn)
    p2gui.on_next_turn(turn)

func on_dice_rolled(sides):
    self.player_gui.set_player_roll(sides)
    self.opponent_gui.set_opponent_roll(sides)

func on_dice_dimensioned(diceidx):
    self.player_gui.dicepool.mark_dimensioned(diceidx)

func on_player_lost(_player):
    get_tree().quit()
