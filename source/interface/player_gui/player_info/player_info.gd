tool
extends PanelContainer

# export variables
export (int, 1, 2) var playerid = 1 setget set_playerid
export (String, "Player", "Opponent") var title = "Player" setget set_title

# variables
var player

# onready variables
onready var hearts = $InfoBox/CHBox/Hearts
onready var icrestpool = $InfoBox/CHBox/ICrestPool

# set functions
func set_playerinfo(_player, _title):
    player = _player
    hearts.set_player(player)
    icrestpool.set_crestpool(player.crestpool)
    set_title(_title)

func update_info():
    update_icrestpool()
    update_hearts()

func update_icrestpool():
    icrestpool.update_slots()

func update_hearts():
    hearts.update_hearts()

func set_title(_title):
    title = _title
    $InfoBox/Title.text = title

func set_playerid(_playerid):
    playerid = _playerid
    $InfoBox/CHBox/Hearts.set_player_hearts(playerid, 3)
