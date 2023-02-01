extends VBoxContainer

# variables
var engine
var player
var opponent

# onready variables
onready var main_window = $MainWindow
onready var dicepool_window = $MainWindow/DicepoolWindow
onready var dicepool_column = $MainWindow/DicepoolWindow/DicepoolPanel/DicepoolVBox/DicepoolColumn
onready var roll_gui = $MainWindow/DicepoolWindow/RollPanel/RollVBox/RollGUI
onready var dice_triplet = $MainWindow/DicepoolWindow/RollPanel/RollVBox/RollGUI/DiceTriplet
onready var dungeon_window = $MainWindow/DungeonWindow
onready var idungeon = $MainWindow/DungeonWindow/IDungeon
onready var net_select_buttons = $MainWindow/DungeonWindow/IDungeon/NetSelectButtons
onready var move_menu = $MainWindow/DungeonWindow/IDungeon/MoveMenu
onready var attack_menu = $MainWindow/DungeonWindow/IDungeon/AttackMenu
onready var reply_menu = $MainWindow/DungeonWindow/IDungeon/ReplyMenu
onready var summon_info = $MainWindow/DungeonWindow/SummonPanel/SummonInfo
onready var dungeon_info_button = $MainWindow/DungeonWindow/SummonPanel/SummonInfo/InfoButton
onready var dungeon_buttons = $MainWindow/DungeonWindow/DungeonButtons
onready var dim_buttons = $MainWindow/DungeonWindow/DimButtons
onready var card_info = $CardInfo
onready var common_window = $CommonWindow
onready var players_info = $CommonWindow/PlayersInfo

func _ready():
    # signal connections
    # dicepool column
    dicepool_column.connect("dice_triplet_changed", roll_gui, "update_dice_triplet")
    dicepool_column.connect("dice_dim_button_pressed", roll_gui, "on_dice_dim_button_pressed")
    dicepool_column.connect("dice_dim_button_pressed", dungeon_window, "on_dice_dim_button_pressed")
    dicepool_column.connect("dice_dim_button_released", roll_gui, "on_dice_dim_button_released")
    dicepool_column.connect("dice_dim_button_released", dungeon_window, "on_dice_dim_button_released")
    dicepool_column.connect("info_button_pressed", self, "on_info_button_pressed")
    # roll gui
    roll_gui.connect("roll_button_pressed", self, "on_roll_button_pressed")
    roll_gui.connect("skip_button_pressed", self, "on_skip_button_pressed")
    # idungeon
    idungeon.connect("tile_select_button_toggled", summon_info, "on_tile_select_button_toggled")
    idungeon.connect("tile_select_button_toggled", dungeon_buttons, "on_tile_select_button_toggled")
    idungeon.connect("net_updated", dim_buttons, "on_net_updated")
    idungeon.connect("menu_opened", dungeon_buttons, "on_menu_opened")
    idungeon.connect("monster_lord_attacked", self, "on_attack_input")
    # net creator
    idungeon.net_creator.connect("net_updated", idungeon, "on_net_updated")
    # net select buttons
    net_select_buttons.connect("net_select_button_pressed", idungeon.net_creator, "update_netidx")
    # dungeon info button
    dungeon_info_button.connect("info_button_pressed", self, "on_info_button_pressed")
    # dungeon buttons
    dungeon_buttons.connect("move_button_pressed", idungeon, "on_move_button_pressed")
    dungeon_buttons.connect("attack_button_pressed", idungeon, "on_attack_button_pressed")
    dungeon_buttons.connect("cancel_button_pressed", dungeon_window, "reset_to_dungeon")
    dungeon_buttons.connect("endturn_button_pressed", self, "on_endturn_button_pressed")
    # dim buttons
    dim_buttons.connect("net_button_pressed", idungeon, "on_net_button_pressed")
    dim_buttons.connect("FLR_button_pressed", idungeon, "on_FLR_button_pressed")
    dim_buttons.connect("FUD_button_pressed", idungeon, "on_FUD_button_pressed")
    dim_buttons.connect("TCW_button_pressed", idungeon, "on_TCW_button_pressed")
    dim_buttons.connect("TAW_button_pressed", idungeon, "on_TAW_button_pressed")
    dim_buttons.connect("dim_button_pressed", dicepool_column, "release_roll")
    dim_buttons.connect("dim_button_pressed", self, "on_dim_button_pressed")
    # move menu
    move_menu.connect("menu_move_button_pressed", self, "on_menu_move_button_pressed")
    move_menu.connect("menu_canceled", dungeon_window, "reset_to_dungeon")
    # attack menu
    attack_menu.connect("menu_attack_button_pressed", self, "on_attack_input")
    attack_menu.connect("menu_canceled", dungeon_window, "reset_to_dungeon")
    # reply menu
    reply_menu.connect("menu_guard_button_pressed", self, "on_menu_guard_button_pressed")
    reply_menu.connect("menu_wait_button_pressed", self, "on_menu_wait_button_pressed")
    # card info
    card_info.connect("card_info_quit", self, "on_card_info_quit")
    # common window
    common_window.connect("window_button_pressed", self, "on_window_button_pressed")

# setget functions
func set_duel(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    dicepool_column.set_dicepool(player.dicepool)
    idungeon.set_dungeon(engine.dungeon, player)
    summon_info.set_player(player)
    dungeon_buttons.set_dungeon_buttons(player, engine)
    players_info.set_players_info(player, opponent)

func set_roll(sides):
    dice_triplet.set_roll(sides)

# signals callbacks
func on_roll_button_pressed():
    var indeces = dicepool_column.get_roll_indeces()
    engine.update({"name":"ROLL", "dice":indeces})

func on_skip_button_pressed():
    engine.update({"name":"SKIP"})

func on_dim_button_pressed():
    var dimdice = dicepool_column.get_selected_dim_idx()
    var netdata = idungeon.net_creator.get_netdata()
    var net = netdata["netname"]
    var pos = netdata["pos"]
    var trans = netdata["trans_list"]
    engine.update({"name":"DIM", "dice":dimdice, "net":net, "pos":pos, "trans":trans})

func on_menu_move_button_pressed(pos1, pos2):
    dungeon_window.reset_to_dungeon()
    engine.update({"name":"MOVE", "origin":pos1, "dest":pos2})

func on_attack_input(pos1, pos2):
    dungeon_window.reset_to_dungeon()
    engine.update({"name":"ATTACK", "origin":pos1, "dest":pos2})

func on_menu_guard_button_pressed():
    engine.update({"name":"GUARD"})

func on_menu_wait_button_pressed():
    engine.update({"name":"WAIT"})

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

# private functions
func switch_to_dicepool_window():
    dicepool_window.visible = true
    dungeon_window.visible = false

func switch_to_dungeon_window():
    dicepool_window.visible = false
    dungeon_window.visible = true
