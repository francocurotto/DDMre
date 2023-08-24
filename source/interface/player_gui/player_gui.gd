extends PanelContainer

# variables
var engine
var player
var opponent

# onready variables
@onready var dicepool_gui = $DicepoolGUI

# public functions
func setup(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    dicepool_gui.setup(player.dicepool)
