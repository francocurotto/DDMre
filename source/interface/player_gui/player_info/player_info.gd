extends PanelContainer

# variables
var player

# public functions
func setup(_player):
    player = _player
    %HeartsInfo.setup(player)
    %CrestpoolInfo.setup(player.crestpool)
    
