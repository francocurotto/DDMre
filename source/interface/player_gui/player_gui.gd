extends VBoxContainer

# variables
var engine
var player
var opponent

# onready variables
onready var main_window = $MainWindow
onready var dicepool_window = $MainWindow/DicepoolWindow
onready var dicepool_gui = $MainWindow/DicepoolWindow/DicepoolGUI
onready var roll_gui = $MainWindow/DicepoolWindow/RollGUI
onready var dungeon_window = $MainWindow/DungeonWindow
onready var idungeon = $MainWindow/DungeonWindow/IDungeon
onready var net_select_buttons = $MainWindow/DungeonWindow/IDungeon/NetSelectButtons
onready var move_menu = $MainWindow/DungeonWindow/IDungeon/MoveMenu
onready var attack_menu = $MainWindow/DungeonWindow/IDungeon/AttackMenu
onready var reply_menu = $MainWindow/DungeonWindow/IDungeon/ReplyMenu
onready var summon_info = $MainWindow/DungeonWindow/SummonPanel/SummonInfo
onready var dungeon_info_button = $MainWindow/DungeonWindow/SummonPanel/SummonInfo/InfoButton
onready var dungeon_buttons = $MainWindow/DungeonWindow/DungeonButtons
onready var reply_ability_buttons = $MainWindow/DungeonWindow/DungeonButtons/ReplyAbilityButtons
onready var dim_buttons = $MainWindow/DungeonWindow/DimButtons
onready var card_info = $CardInfo
onready var common_window = $LowerWindow
onready var players_info = $LowerWindow/PlayersInfo

func _ready():
    # signal connections
    # dicepool gui
    dicepool_gui.connect("dicepool_gui_changed", roll_gui, "on_dicepool_gui_changed")
    dicepool_gui.connect("dice_gui_dim_button_pressed", roll_gui, "on_dice_gui_dim_button_pressed")
    dicepool_gui.connect("dice_gui_dim_button_pressed", dungeon_window, "on_dice_gui_dim_button_pressed")
    dicepool_gui.connect("dice_gui_dim_button_released", roll_gui, "on_dice_gui_dim_button_released")
    dicepool_gui.connect("dice_gui_dim_button_released", dungeon_window, "on_dice_gui_dim_button_released")
    dicepool_gui.connect("dice_gui_info_button_pressed", self, "on_info_button_pressed")
    # roll gui
    roll_gui.connect("roll_gui_roll_button_pressed", self, "on_roll_gui_roll_button_pressed")
    roll_gui.connect("roll_gui_skip_button_pressed", self, "on_roll_gui_skip_button_pressed")
    # idungeon
    idungeon.connect("tile_select_button_toggled", summon_info, "on_tile_select_button_toggled")
    idungeon.connect("tile_select_button_toggled", dungeon_buttons, "on_tile_select_button_toggled")
    idungeon.connect("net_updated", dim_buttons, "on_net_updated")
    idungeon.connect("menu_opened", dungeon_buttons, "on_menu_opened")
    idungeon.connect("attack_cmd", self, "on_attack_cmd")
    idungeon.connect("monster_jumped", self, "on_jump_input")
    # net creator
    idungeon.net_creator.connect("net_updated", idungeon, "on_net_updated")
    # net select buttons
    net_select_buttons.connect("net_select_button_pressed", idungeon.net_creator, "update_netidx")
    # dungeon info button
    dungeon_info_button.connect("info_button_pressed", self, "on_info_button_pressed")
    # dungeon buttons
    dungeon_buttons.connect("move_button_pressed", idungeon, "on_move_button_pressed")
    dungeon_buttons.connect("attack_button_pressed", idungeon, "on_attack_button_pressed")
    dungeon_buttons.connect("jump_button_pressed", idungeon, "on_jump_button_pressed")
    dungeon_buttons.connect("endturn_button_pressed", self, "on_endturn_button_pressed")
    dungeon_buttons.connect("cancel_button_pressed", dungeon_window, "reset_to_dungeon")
    # reply ability buttons
    reply_ability_buttons.connect("cancel_reply_ability_button_pressed", self, "on_cancel_reply_ability_button_pressed")
    reply_ability_buttons.connect("select_reply_ability_button_pressed", self, "on_select_reply_ability_button_pressed")
    # dim buttons
    dim_buttons.connect("net_button_pressed", idungeon, "on_net_button_pressed")
    dim_buttons.connect("FLR_button_pressed", idungeon, "on_FLR_button_pressed")
    dim_buttons.connect("FUD_button_pressed", idungeon, "on_FUD_button_pressed")
    dim_buttons.connect("TCW_button_pressed", idungeon, "on_TCW_button_pressed")
    dim_buttons.connect("TAW_button_pressed", idungeon, "on_TAW_button_pressed")
    dim_buttons.connect("dim_button_pressed", dicepool_gui, "release_roll")
    dim_buttons.connect("dim_button_pressed", self, "on_dim_button_pressed")
    # move menu
    move_menu.connect("menu_move_button_pressed", self, "on_menu_move_button_pressed")
    move_menu.connect("menu_canceled", dungeon_window, "reset_to_dungeon")
    # attack menu
    attack_menu.connect("attack_cmd", self, "on_attack_cmd")
    attack_menu.connect("menu_canceled", dungeon_window, "reset_to_dungeon")
    # reply menu
    reply_menu.connect("reply_cmd", self, "on_reply_cmd")
    reply_menu.connect("shiftdamage_button_pressed", self, "on_shiftdamage_button_pressed")
    # card info
    card_info.connect("card_info_quit", self, "on_card_info_quit")
    # common window
    common_window.connect("window_button_pressed", self, "on_window_button_pressed")

# setget functions
func set_duel(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    dicepool_gui.set_dicepool(player.dicepool)
    idungeon.set_dungeon(engine.dungeon, player)
    summon_info.set_player(player)
    dungeon_buttons.set_dungeon_buttons(player, engine)
    players_info.set_players_info(player, opponent)

func set_roll(sides):
    roll_gui.set_roll(sides)

# signals callbacks
func on_roll_gui_roll_button_pressed():
    var indeces = dicepool_gui.get_roll_indeces()
    engine.update({"name":"ROLL", "dice":indeces})

func on_roll_gui_skip_button_pressed():
    engine.update({"name":"SKIP"})

func on_dim_button_pressed():
    var dimdice = dicepool_gui.get_selected_dim_index()
    var netdata = idungeon.net_creator.get_netdata()
    var net = netdata["netname"]
    var pos = netdata["pos"]
    var trans = netdata["trans_list"]
    engine.update({"name":"DIM", "dice":dimdice, "net":net, "pos":pos, "trans":trans})

func on_menu_move_button_pressed(pos1, pos2):
    dungeon_window.reset_to_dungeon()
    engine.update({"name":"MOVE", "origin":pos1, "dest":pos2})

func on_attack_cmd(cmd):
    dungeon_window.reset_to_dungeon()
    engine.update(cmd)

func on_reply_cmd(cmd):
    engine.update(cmd)

func on_jump_input(pos1, pos2):
    dungeon_window.reset_to_dungeon()
    engine.update({"name":"JUMP", "origin":pos1, "dest":pos2})

func on_endturn_button_pressed():
    engine.update({"name":"ENDTURN"})

func on_state_update_roll():
    switch_to_dicepool_window()
    dicepool_window.on_state_update_roll()
    dungeon_window.on_state_update_roll()

func on_state_update_dungeon():
    dicepool_window.on_state_update_dungeon()
    dungeon_window.on_state_update_dungeon()

func on_state_update_dimension():
    dicepool_window.on_state_update_dimension(engine.state.dim_candidates)

func on_state_update_reply():
    switch_to_dungeon_window()
    dicepool_window.on_state_update_reply()
    dungeon_window.on_state_update_reply(engine.state.attacker, engine.state.attacked)

func on_info_button_pressed(card):
    card_info.set_card(card)
    main_window.visible = false
    card_info.visible = true

func on_card_info_quit():
    card_info.visible = false
    main_window.visible = true

func on_window_button_pressed():
    dicepool_window.visible = not dicepool_window.visible
    dungeon_window.visible = not dungeon_window.visible

func on_shiftdamage_button_pressed():
    var monsters = engine.state.attacked.get_player_other_monsters()
    idungeon.enable_select_buttons()
    dungeon_buttons.switch_to_cancel_reply_ability_button(monsters)
    idungeon.connect("tile_select_button_toggled", reply_ability_buttons, "on_tile_select_button_toggled")

func on_cancel_reply_ability_button_pressed():
    dungeon_buttons.switch_to_action_buttons()
    idungeon.disconnect("tile_select_button_toggled", reply_ability_buttons, "on_tile_select_button_toggled")
    idungeon.on_cancel_reply_ability_button_pressed()

func on_select_reply_ability_button_pressed():
    dungeon_buttons.switch_to_action_buttons()
    idungeon.disconnect("tile_select_button_toggled", reply_ability_buttons, "on_tile_select_button_toggled")
    idungeon.on_select_reply_ability_button_pressed()

# private functions
func switch_to_dicepool_window():
    dicepool_window.visible = true
    dungeon_window.visible = false

func switch_to_dungeon_window():
    dicepool_window.visible = false
    dungeon_window.visible = true
