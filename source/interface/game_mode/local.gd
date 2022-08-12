extends PanelContainer

const Engine = preload("res://engine/engine.gd")

var engine

func _ready():
    randomize()
    engine = Engine.new()
    set_guis()
    # connections
    engine.connect("state_update", self, "on_state_update")
    engine.connect("next_turn", self, "on_next_turn")
    # run first state update
    on_state_update(engine.state.NAME)

func set_guis():
    $P1GUI.set_duel(engine, engine.player1, engine.player2)
    $P2GUI.set_duel(engine, engine.player2, engine.player1) 

func on_state_update(state_name):
    match state_name:
        "ROLL" : on_state_update_roll()
        "DUNGEON" : on_state_update_dungeon()
        
func on_state_update_roll():
    # state connections
    engine.state.connect("dice_rolled", self, "on_dice_rolled")
    # player gui specific
    get_player_gui().on_state_update_roll()

func on_state_update_dungeon():
    get_player_gui().on_state_update_dungeon()

func on_next_turn():
    get_player_gui().visible = true
    get_opponent_gui().visible = false

func on_dice_rolled(sides):
    get_player_gui().set_player_roll(sides)
    get_opponent_gui().set_opponent_roll(sides)
    get_player_gui().update_player_crestpool()
    get_opponent_gui().update_opponent_crestpool()

func get_player_gui():
    return get_children()[engine.state.player.id-1]

func get_opponent_gui():
    return get_children()[engine.state.opponent.id-1]
