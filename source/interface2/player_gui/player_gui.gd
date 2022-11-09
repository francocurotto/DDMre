extends VBoxContainer

# variables
var engine
var player
var opponent

# onready variables
onready var dicepool_window = $DicepoolWindow

# setget functions
func set_duel(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    dicepool_window.set_dicepool(player.dicepool, player.dimdice)
