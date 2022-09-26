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
onready var infobox = $"%InfoBox"
onready var idungeon = $"%IDungeon"

func _ready():
    rollgui.hide_rolls()
    # connections
    dicepool.connect("roll_changed", self, "on_roll_changed")
    dicepool.connect("mouse_entered_dice", infobox, "on_mouse_entered_dice")
    dicepool.connect("mouse_exited_dice", infobox, "on_mouse_exited_dice")
    idungeon.connect("mouse_entered_summon", infobox, "on_mouse_entered_summon")
    idungeon.connect("mouse_exited_tile", infobox, "on_mouse_exited_tile")
    rollgui.connect("roll_input", self, "on_roll_input")
    rollgui.connect("endturn_input", self, "on_endturn_input")
    idungeon.connect("move_input", self, "on_move_input")
    idungeon.connect("attack_input", self, "on_attack_input")

# setget functions
func set_duel(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    dicepool.set_dicepool(player.dicepool)
    playerinfo.set_playerinfo(player, "Player")
    opponentinfo.set_playerinfo(opponent, "Opponent")
    idungeon.set_dungeon(engine.dungeon, player)
    infobox.set_player(player)

func update_gui():
    idungeon.update_dungeon()
    playerinfo.update_info()
    opponentinfo.update_info()
    infobox.hide_all()

func set_player_roll(sides):
    rollgui.update_roll_player(sides)

func set_opponent_roll(sides):
    rollgui.update_roll_opponent(sides)

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
    infobox.hide_all()

func on_state_update_reply():
    dicepool.disable_all()
    rollgui.disable_roll()
    rollgui.disable_endturn()
    idungeon.disable_itilebuttons()
    idungeon.mark_reply_monsters(engine.state)

func on_next_turn(turn):
    duelinfo.on_next_turn(turn)
    idungeon.unselect_itile()

func on_roll_changed():
    rollgui.set_roll_button(dicepool.roll_ready())

func on_roll_input():
    var indeces = dicepool.get_indeces()
    engine.update({"name" : "ROLL", "dice" : indeces})

func on_endturn_input():
    engine.update({"name" : "ENDTURN"})

func on_move_input(pos1, pos2):
    engine.update({"name" : "MOVE", "origin" : pos1, "dest" : pos2})

func on_attack_input(pos1, pos2):
    engine.update({"name" : "ATTACK", "origin" : pos1, "dest" : pos2})

func on_guard_input():
    engine.update({"name" : "GUARD"})

func on_wait_input():
    engine.update({"name" : "WAIT"})
