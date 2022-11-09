extends VBoxContainer

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
    pass
