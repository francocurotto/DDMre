tool
extends HBoxContainer

# export variables
export (int, 1, 2) var playerid = 1 setget set_playerid

# onready variables
onready var hearts = $Hearts
onready var icrestpool = $ICrestpool

# setget functions
func set_player_info(player):
    hearts.set_player(player)
    icrestpool.set_crestpool(player.crestpool)

func set_playerid(_playerid):
    playerid = _playerid
    if has_node("Hearts"):
        $Hearts.set_playerid(_playerid)
