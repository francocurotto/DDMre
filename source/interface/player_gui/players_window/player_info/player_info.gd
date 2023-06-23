tool
extends PanelContainer

# export variables
export (int, 1, 2) var playerid = 1 setget set_playerid

# onready variables
onready var hearts_info = $PlayerInfoHBox/HeartsInfo
onready var crestpool_info = $PlayerInfoHBox/CrestpoolInfo

# setget functions
func set_player_info(player):
    hearts_info.set_player(player)
    crestpool_info.set_crestpool(player.crestpool)

func set_playerid(_playerid):
    playerid = _playerid
    $PlayerInfoHBox/HeartsInfo.set_playerid(_playerid)
