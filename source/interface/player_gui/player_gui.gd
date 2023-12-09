extends PanelContainer

# variables
var engine
var player
var opponent

# public functions
func setup(_engine, _player, _opponent):
    engine = _engine
    player = _player
    opponent = _opponent
    #$DicepoolWindow.setup(player.dicepool)
    $DungeonGUI.setup(player, engine.state.dungeon)
