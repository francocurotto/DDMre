extends VBoxContainer

# preload variables
var CardInfo = preload("res://interface2/player_gui/info_display/card_info/card_info.tscn")

# variables
var engine
var player
var opponent
var cardinfo

# onready variables
onready var dicepool_window = $DicepoolWindow
onready var dicepool_column = $DicepoolWindow/DicepoolPanel/DicepoolVBox/DicepoolColumn
onready var dice_triplet = $DicepoolWindow/RollPanel/RollVBox/RollGUI/DiceTriplet
onready var dungeon_window = $DungeonWindow
onready var idungeon = $DungeonWindow/IDungeon
onready var menu_bar = $CommonWindow/MenuBar
onready var players_info = $CommonWindow/PlayersInfo

func _ready():
    # signal connections
    dicepool_column.connect("info_button_pressed", self, "on_info_button_pressed")
    dicepool_window.connect("roll_button_pressed", self, "on_roll_button_pressed")
    menu_bar.connect("window_button_pressed", self, "on_window_button_pressed")

# setget functions
func set_duel(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    dicepool_column.set_dicepool(player.dicepool)
    idungeon.set_dungeon(engine.dungeon, player)
    players_info.set_players_info(player, opponent)

func set_roll(sides):
    dice_triplet.set_roll(sides)

# signals callbacks
func on_info_button_pressed(card):
    create_cardinfo(card)
    dicepool_window.visible = false

func on_cardinfo_quit():
    cardinfo.queue_free()
    dicepool_window.visible = true

func on_window_button_pressed():
    dicepool_window.visible = not dicepool_window.visible
    dungeon_window.visible = not dungeon_window.visible

func on_roll_button_pressed(indeces):
    engine.update({"name":"ROLL", "dice":indeces})

func on_state_update_dungeon():
    dicepool_window.on_state_update_dungeon()

func on_state_update_dimension():
    dicepool_window.on_state_update_dimension(engine.state.dim_candidates)

# private functions
func create_cardinfo(card):
    cardinfo = CardInfo.instance()
    add_child_below_node(dicepool_window, cardinfo)
    cardinfo.connect("cardinfo_quit", self, "on_cardinfo_quit")
    cardinfo.set_card(card)
    return cardinfo

