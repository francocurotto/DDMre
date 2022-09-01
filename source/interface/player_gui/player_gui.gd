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
onready var idungeon = $"%IDungeon"

func _ready():
    rollgui.hide_rolls()
    # connections
    dicepool.connect("roll_changed", self, "on_roll_changed")
    rollgui.connect("roll_pressed", self, "on_roll_pressed")
    rollgui.connect("endturn_pressed", self, "on_endturn_pressed")
    dicepool.connect("mouse_entered_dice", iteminfo, "on_mouse_entered_dice")
    dicepool.connect("mouse_exited_dice", iteminfo, "on_mouse_exited_dice")
    idungeon.connect("mouse_entered_dungobj", iteminfo, "on_mouse_entered_dungobj")
    idungeon.connect("mouse_exited_dungobj", iteminfo, "on_mouse_exited_dungobj")
    idungeon.connect("move_input", self, "on_move_input")
    idungeon.connect("attack_input", self, "on_attack_input")

# set functions
func set_duel(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    dicepool.set_dicepool(player.dicepool)
    playerinfo.set_infobox(player, "Player")
    opponentinfo.set_infobox(opponent, "Opponent")
    idungeon.set_dungeon(engine.dungeon, player)
    iteminfo.set_player(player)

func update_gui():
    idungeon.update_dungeon()
    playerinfo.update_infobox()
    opponentinfo.update_infobox()

func set_player_roll(sides):
    rollgui.update_roll_player(sides)

func set_opponent_roll(sides):
    rollgui.update_roll_opponent(sides)
    
func update_player_icrestpool():
    playerinfo.update_icrestpool()

func update_opponent_icrestpool():
    opponentinfo.update_icrestpool()

# signals callback
func on_state_update(state):
    duelinfo.on_state_update(state)

func on_state_update_roll():
    dicepool.enable_all()
    dicepool.release_all()
    rollgui.hide_player_roll()
    rollgui.disable_endturn()
    idungeon.disable_itilebuttons()

func on_state_update_dungeon():
    dicepool.disable_all()
    rollgui.disable_roll()
    rollgui.enable_endturn()
    idungeon.enable_itilebuttons()

func on_next_turn(turn):
    duelinfo.on_next_turn(turn)

func on_roll_changed():
    rollgui.set_roll_button(dicepool.roll_ready())

func on_roll_pressed():
    var indeces = dicepool.get_indeces()
    engine.update({"name" : "ROLL", "dice" : indeces})

func on_endturn_pressed():
    idungeon.unselect_itile()
    engine.update({"name" : "ENDTURN"})

func on_move_input(pos1, pos2):
    engine.update({"name" : "MOVE", "origin" : pos1, "dest" : pos2})

func on_attack_input(pos1, pos2):
    engine.update({"name" : "ATTACK", "origin" : pos1, "dest" : pos2})
