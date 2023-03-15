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
onready var dungeon_gui = $MainWindow/DungeonWindow/DungeonGUI
onready var nets_menu = $MainWindow/DungeonWindow/DungeonGUI/NetsMenu
onready var move_menu = $MainWindow/DungeonWindow/DungeonGUI/MoveMenu
onready var attack_menu = $MainWindow/DungeonWindow/DungeonGUI/AttackMenu
onready var reply_menu = $MainWindow/DungeonWindow/DungeonGUI/ReplyMenu
onready var reply_ability_gui = $MainWindow/DungeonWindow/DungeonGUI/ReplyMenu/VBox/Margins/GUIVBox/ReplyAbilityGUI
onready var summon_gui = $MainWindow/DungeonWindow/SummonGUI
onready var dungeon_buttons = $MainWindow/DungeonWindow/DungeonButtonsGUI/DungeonButtons
onready var dim_buttons = $MainWindow/DungeonWindow/DungeonButtonsGUI/DimButtons
onready var ability_buttons_gui = $MainWindow/DungeonWindow/DungeonButtonsGUI/AbilityButtonsGUI
onready var card_info = $CardInfo
onready var lower_window = $LowerWindow

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
    # dungeon gui
    dungeon_gui.connect("tile_select_button_toggled", summon_gui, "on_tile_select_button_toggled")
    dungeon_gui.connect("tile_select_button_toggled", dungeon_buttons, "on_tile_select_button_toggled")
    dungeon_gui.connect("net_updated", dim_buttons, "on_net_updated")
    dungeon_gui.connect("menu_opened", dungeon_buttons, "on_menu_opened")
    dungeon_gui.connect("attack_cmd", self, "on_attack_cmd")
    dungeon_gui.connect("monster_jumped", self, "on_jump_input")
    # net creator
    dungeon_gui.net_creator.connect("net_updated", dungeon_gui, "on_net_updated")
    # dungeon info button
    summon_gui.connect("summon_gui_info_button_pressed", self, "on_info_button_pressed")
    # dungeon buttons
    dungeon_buttons.connect("move_button_pressed", dungeon_gui, "on_move_button_pressed")
    dungeon_buttons.connect("attack_button_pressed", dungeon_gui, "on_attack_button_pressed")
    dungeon_buttons.connect("jump_button_pressed", dungeon_gui, "on_jump_button_pressed")
    dungeon_buttons.connect("endturn_button_pressed", self, "on_endturn_button_pressed")
    dungeon_buttons.connect("cancel_button_pressed", dungeon_window, "reset_to_dungeon")
    # ability buttons gui
    #ability_buttons_gui.connect("cancel_reply_ability_button_pressed", self, "on_cancel_reply_ability_button_pressed")
    #ability_buttons_gui.connect("select_reply_ability_button_pressed", self, "on_select_reply_ability_button_pressed")
    # dim buttons
    dim_buttons.connect("net_button_pressed", dungeon_gui, "on_net_button_pressed")
    dim_buttons.connect("FLR_button_pressed", dungeon_gui, "on_FLR_button_pressed")
    dim_buttons.connect("FUD_button_pressed", dungeon_gui, "on_FUD_button_pressed")
    dim_buttons.connect("TCW_button_pressed", dungeon_gui, "on_TCW_button_pressed")
    dim_buttons.connect("TAW_button_pressed", dungeon_gui, "on_TAW_button_pressed")
    dim_buttons.connect("dim_button_pressed", dicepool_gui, "release_roll")
    dim_buttons.connect("dim_button_pressed", self, "on_dim_button_pressed")
    # nets menu
    nets_menu.connect("net_select_button_pressed", dungeon_gui.net_creator, "update_net_index")
    # move menu
    move_menu.connect("menu_move_button_pressed", self, "on_menu_move_button_pressed")
    move_menu.connect("menu_canceled", dungeon_window, "reset_to_dungeon")
    # attack menu
    attack_menu.connect("attack_cmd", self, "on_attack_cmd")
    attack_menu.connect("menu_canceled", dungeon_window, "reset_to_dungeon")
    # reply menu
    reply_menu.connect("reply_cmd", self, "on_reply_cmd")
    # reply ability gui
    reply_ability_gui.connect("reply_ability_cost_changed", reply_menu, "on_reply_ability_cost_changed")
    reply_ability_gui.connect("reply_ability_select_monster", self, "on_reply_ability_select_monster")
    # card info
    card_info.connect("card_info_quit", self, "on_card_info_quit")
    # common window
    lower_window.connect("switch_button_pressed", self, "on_switch_button_pressed")

# setget functions
func set_duel(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    dicepool_gui.set_dicepool(player.dicepool)
    dungeon_gui.set_dungeon(engine.dungeon, player)
    summon_gui.set_player(player)
    dungeon_buttons.set_dungeon_buttons(player, engine)
    lower_window.set_players_info(player, opponent)

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
    var netdata = dungeon_gui.net_creator.get_netdata()
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
    lower_window.disable_switch_button()

func on_card_info_quit():
    card_info.visible = false
    main_window.visible = true
    lower_window.enable_switch_button()

func on_switch_button_pressed():
    dicepool_window.visible = not dicepool_window.visible
    dungeon_window.visible = not dungeon_window.visible

func on_reply_ability_select_monster():
    reply_menu.visible = false
    var monsters = engine.state.attacked.get_player_other_monsters()
    dungeon_gui.enable_select_buttons()
    dungeon_gui.connect("tile_select_button_toggled", ability_buttons_gui, "on_tile_select_button_toggled")
    dungeon_buttons.switch_to_cancel_reply_ability_button(monsters)

func on_cancel_reply_ability_button_pressed():
    dungeon_buttons.switch_to_action_buttons()
    dungeon_gui.disconnect("tile_select_button_toggled", ability_buttons_gui, "on_tile_select_button_toggled")
    dungeon_gui.on_cancel_reply_ability_button_pressed()

func on_select_reply_ability_button_pressed():
    dungeon_buttons.switch_to_action_buttons()
    dungeon_gui.disconnect("tile_select_button_toggled", ability_buttons_gui, "on_tile_select_button_toggled")
    dungeon_gui.on_select_reply_ability_button_pressed()

# private functions
func switch_to_dicepool_window():
    dicepool_window.visible = true
    dungeon_window.visible = false

func switch_to_dungeon_window():
    dicepool_window.visible = false
    dungeon_window.visible = true
