extends PanelContainer

# variables
var engine
var player
var opponent

# onready variables
onready var dicepool = $"%Dicepool"
onready var rollgui = $"%RollGUI"
onready var playerinfo = $"%PlayerInfo"
onready var opponentinfo = $"%OpponentInfo"
onready var duelinfo = $"%DuelInfo"
onready var iteminfo = $"%ItemInfo"
onready var dungeon = $"%Dungeon"

func _ready():
    rollgui.hide_rolls()
    # connections
    dicepool.connect("roll_changed", self, "on_roll_changed")
    rollgui.connect("roll_pressed", self, "on_roll_pressed")
    rollgui.connect("endturn_pressed", self, "on_endturn_pressed")
    dicepool.connect("mouse_entered_dice", iteminfo, "on_mouse_entered_dice")
    dicepool.connect("mouse_exited_dice", iteminfo, "on_mouse_exited_dice")
    dungeon.connect("mouse_entered_dungobj", iteminfo, "on_mouse_entered_dungobj")
    dungeon.connect("mouse_exited_dungobj", iteminfo, "on_mouse_exited_dungobj")
    dungeon.connect("move_input", self, "on_move_input")

# set functions
func set_duel(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    dicepool.set_dicepool(player.dicepool)
    playerinfo.set_infobox(player, "Player")
    opponentinfo.set_infobox(opponent, "Opponent")
    dungeon.set_dungeon(engine.dungeon, player)
    iteminfo.set_player(player)

func update_gui():
    dungeon.update_dungeon()
    playerinfo.update_infobox()
    opponentinfo.update_infobox()

func set_player_roll(sides):
    rollgui.update_roll_player(sides)

func set_opponent_roll(sides):
    rollgui.update_roll_opponent(sides)
    
func update_player_crestpool():
    playerinfo.update_crestpool()

func update_opponent_crestpool():
    opponentinfo.update_crestpool()

# signals callback
func on_state_update(state):
    duelinfo.on_state_update(state)

func on_state_update_roll():
    dicepool.enable_all()
    dicepool.release_all()
    rollgui.hide_player_roll()
    rollgui.disable_endturn()
    dungeon.disable_tilebuttons()

func on_state_update_dungeon():
    dicepool.disable_all()
    rollgui.disable_roll()
    rollgui.enable_endturn()
    dungeon.enable_tilebuttons()

func on_next_turn(turn):
    duelinfo.on_next_turn(turn)

func on_roll_changed():
    rollgui.set_roll_button(dicepool.roll_ready())

func on_roll_pressed():
    var indeces = dicepool.get_indeces()
    engine.update({"name" : "ROLL", "dice" : indeces})

func on_endturn_pressed():
    dungeon.unselect_tile()
    engine.update({"name" : "ENDTURN"})

func on_move_input(pos1, pos2):
    engine.update({"name" : "MOVE", "origin" : pos1, "dest" : pos2})
