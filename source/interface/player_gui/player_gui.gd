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
    dicepool.connect("skip_input", self, "on_skip_input")
    dicepool.connect("dimdice_selected", idungeon, "on_dimdice_selected")
    dicepool.connect("dimdice_unselected", idungeon, "on_dimdice_unselected")
    rollgui.connect("roll_input", self, "on_roll_input")
    rollgui.connect("endturn_input", self, "on_endturn_input")
    idungeon.connect("mouse_entered_summon", infobox, "on_mouse_entered_summon")
    idungeon.connect("mouse_exited_tile", infobox, "on_mouse_exited_tile")
    idungeon.connect("mouse_entered_target", infobox, "on_mouse_entered_target")
    idungeon.connect("dim_input", self, "on_dim_input")
    idungeon.connect("move_input", self, "on_move_input")
    idungeon.connect("attack_input", self, "on_attack_input")
    idungeon.connect("guard_input", self, "on_guard_input")
    idungeon.connect("wait_input", self, "on_wait_input")
    idungeon.connect("dungeon_menu_opened", self, "on_dungeon_menu_opened")
    idungeon.connect("dungeon_menu_closed", self, "on_dungeon_menu_closed")

# setget functions
func set_duel(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    dicepool.set_dicepool(player.dicepool, player.dimdice)
    playerinfo.set_playerinfo(player, "Player")
    opponentinfo.set_playerinfo(opponent, "Opponent")
    idungeon.set_dungeon(engine.dungeon, player)
    infobox.set_player(player)

func update_gui():
    idungeon.update_dungeon()
    playerinfo.update_info()
    opponentinfo.update_info()

func set_player_roll(sides):
    rollgui.update_roll_player(sides)

func set_opponent_roll(sides):
    rollgui.update_roll_opponent(sides)

# signals callback
func on_state_update(state):
    duelinfo.on_state_update(state)

func on_state_update_roll():
    dicepool.enable_roll_undimensioned()
    dicepool.on_roll_button_pressed() # for handling last roll memory
    dicepool.switch_to_roll_button_undimensioned()
    dicepool.enable_dim_undimensioned()
    rollgui.hide_player_roll()
    rollgui.disable_endturn()
    idungeon.disable_tile_buttons()

func on_state_update_dimension():
    dicepool.disable_roll_all()
    dicepool.enable_dim_candidates(engine.state.dim_candidates)
    rollgui.disable_roll()
    rollgui.disable_endturn()
    idungeon.disable_tile_buttons()

func on_state_update_dungeon():
    dicepool.disable_roll_all()
    rollgui.disable_roll()
    rollgui.enable_endturn()
    idungeon.enable_tile_buttons()
    idungeon.free_net_creator()

func on_state_update_reply():
    dicepool.disable_roll_all()
    rollgui.disable_roll()
    rollgui.disable_endturn()
    idungeon.disable_tile_buttons()
    idungeon.mark_reply_monsters(engine.state)
    idungeon.create_reply_menu(engine.state)

func on_next_turn(turn):
    duelinfo.on_next_turn(turn)
    idungeon.unset_all_itile_mods()

func on_roll_changed():
    rollgui.set_roll_button(dicepool.roll_ready())

func on_dungeon_menu_opened():
    rollgui.disable_endturn()

func on_dungeon_menu_closed():
    rollgui.enable_endturn()

func on_roll_input():
    var indeces = dicepool.get_roll_indeces()
    engine.update({"name":"ROLL", "dice":indeces})

func on_skip_input():
    engine.update({"name":"SKIP"})

func on_endturn_input():
    engine.update({"name":"ENDTURN"})

func on_dim_input(dimdice, net, pos, trans):
    engine.update({"name":"DIM", "dice":dimdice, "net":net, "pos":pos, "trans":trans})

func on_move_input(pos1, pos2):
    rollgui.enable_endturn()
    engine.update({"name":"MOVE", "origin":pos1, "dest":pos2})

func on_attack_input(pos1, pos2):
    rollgui.enable_endturn()
    engine.update({"name":"ATTACK", "origin":pos1, "dest":pos2})

func on_guard_input():
    engine.update({"name":"GUARD"})

func on_wait_input():
    engine.update({"name":"WAIT"})
