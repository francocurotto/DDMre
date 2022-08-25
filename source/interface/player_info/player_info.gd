tool
extends PanelContainer

# export variables
export (int, 1, 2) var playerid = 1 setget set_playerid
export (String, "Player", "Opponent") var title = "Player" setget set_title

# variables
var player

# onready variables
onready var hearts = $InfoBox/CHBox/Hearts
onready var crestpool = $InfoBox/CHBox/CrestPool

# set functions
func set_infobox(_player, _title):
    player = _player
    hearts.set_player(player)
    crestpool.set_crestpool(player.crestpool)
    set_title(_title)

func update_infobox():
    update_crestpool()
    update_hearts()

func update_crestpool():
    crestpool.update_slots()

func update_hearts():
    hearts.update_hearts()

func set_title(_title):
    title = _title
    $InfoBox/Title.text = title

func set_playerid(_playerid):
    playerid = _playerid
    $InfoBox/CHBox/Hearts.set_player_hearts(playerid, 3)
