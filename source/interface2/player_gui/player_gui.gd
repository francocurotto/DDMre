extends VBoxContainer

# preload variables
var CardInfo = preload("res://interface2/player_gui/info_display/card_info/card_info.tscn")

# variables
var engine
var player
var opponent

# onready variables
onready var dicepool_window = $DicepoolWindow

func _ready():
    # signal connections
    dicepool_window.connect("info_button_pressed", self, "on_info_button_pressed")

# setget functions
func set_duel(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    dicepool_window.set_dicepool(player.dicepool, player.dimdice)

# signals callbacks
func on_info_button_pressed(card):
    var cardinfo = create_cardinfo(card)
    display_cardinfo(cardinfo)

# private functions
func create_cardinfo(card):
    var cardinfo = CardInfo.instance()
    add_child_below_node(dicepool_window, cardinfo)
    cardinfo.set_card(card)
    return cardinfo

func display_cardinfo(cardinfo):
    dicepool_window.visible = false
