extends PanelContainer

# preloads
const Engine = preload("res://engine/engine.gd")

# variables
var engine

# onready variables
onready var p1gui = $P1GUI
onready var p2gui = $P2GUI

func _ready():
    randomize()
    engine = Engine.new()
    set_guis()
    # connections
    engine.connect("state_update", self, "on_state_update")
    engine.connect("next_turn", self, "on_next_turn")
    engine.connect("duel_update", self, "on_duel_update")
    # run first state update
    on_state_update(engine.state.NAME)
    on_next_turn(1)

# signals callbacks
func on_state_update(state_name):
    p1gui.on_state_update(state_name)
    p2gui.on_state_update(state_name)
    match state_name:
        "ROLL" : on_state_update_roll()
        "DUNGEON" : on_state_update_dungeon()

func on_next_turn(turn):
    get_player_gui().visible = true
    get_opponent_gui().visible = false
    p1gui.on_next_turn(turn)
    p2gui.on_next_turn(turn)

func on_duel_update():
    p1gui.update_gui()
    p2gui.update_gui()

func on_dice_rolled(sides):
    get_player_gui().set_player_roll(sides)
    get_player_gui().update_player_crestpool()
    get_opponent_gui().set_opponent_roll(sides)
    get_opponent_gui().update_opponent_crestpool()

# private functions
func set_guis():
    p1gui.set_duel(engine, engine.player1, engine.player2)
    p2gui.set_duel(engine, engine.player2, engine.player1) 

func on_state_update_roll():
    # state connections
    engine.state.connect("dice_rolled", self, "on_dice_rolled")
    # player gui specific
    get_player_gui().on_state_update_roll()

func on_state_update_dungeon():
    get_player_gui().on_state_update_dungeon()

func get_player_gui():
    return get_children()[engine.state.player.id-1]

func get_opponent_gui():
    return get_children()[engine.state.opponent.id-1]
