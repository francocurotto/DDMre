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
onready var move_menu = $MainWindow/DungeonWindow/IDungeon/MoveMenu
onready var summon_info = $MainWindow/DungeonWindow/SummonCont/SummonInfo
onready var dungeon_info_button = $MainWindow/DungeonWindow/SummonCont/SummonInfo/InfoButton
onready var dungeon_buttons = $MainWindow/DungeonWindow/DungeonButtons
onready var card_info = $CardInfo
onready var menu_bar = $CommonWindow/MenuBar
onready var players_info = $CommonWindow/PlayersInfo

func _ready():
    # signal connections
    dicepool_column.connect("dice_triplet_changed", roll_gui, "update_dice_triplet")
    dicepool_column.connect("dice_dim_button_pressed", roll_gui, "on_dice_dim_button_pressed")
    dicepool_column.connect("dice_dim_button_pressed", dungeon_window, "on_dice_dim_button_pressed")
    dicepool_column.connect("dice_dim_button_released", roll_gui, "on_dice_dim_button_released")
    dicepool_column.connect("dice_dim_button_released", dungeon_window, "reset_to_dungeon")
    dicepool_column.connect("info_button_pressed", self, "on_info_button_pressed")
    roll_gui.connect("roll_button_pressed", self, "on_roll_button_pressed")
    roll_gui.connect("skip_button_pressed", self, "on_skip_button_pressed")
    ###
    idungeon.connect("dim_button_pressed", self, "on_dim_button_pressed")
    move_menu.connect("menu_move_button_pressed", self, "on_menu_move_button_pressed")
    dungeon_info_button.connect("info_button_pressed", self, "on_info_button_pressed")
    dungeon_buttons.connect("endturn_button_pressed", self, "on_endturn_button_pressed")
    card_info.connect("card_info_quit", self, "on_card_info_quit")
    menu_bar.connect("window_button_pressed", self, "on_window_button_pressed")

# setget functions
func set_duel(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    dicepool_column.set_dicepool(player.dicepool)
    idungeon.set_dungeon(engine.dungeon, player)
    summon_info.set_player(player)
    dungeon_buttons.set_player(player)
    players_info.set_players_info(player, opponent)

func set_roll(sides):
    dice_triplet.set_roll(sides)

# signals callbacks
func on_roll_button_pressed():
    var indeces = dicepool_column.get_roll_indeces()
    engine.update({"name":"ROLL", "dice":indeces})

func on_skip_button_pressed():
    engine.update({"name":"SKIP"})

func on_dim_button_pressed(net, pos, trans):
    var dimdice = dicepool_column.get_selected_dim_idx()
    dicepool_column.release_roll()
    engine.update({"name":"DIM", "dice":dimdice, "net":net, "pos":pos, "trans":trans})

func on_menu_move_button_pressed(pos1, pos2):
    dungeon_window.reset_to_dungeon()
    engine.update({"name":"MOVE", "origin":pos1, "dest":pos2})

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
