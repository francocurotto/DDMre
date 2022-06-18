tool
extends PanelContainer

export (int, 1, 2) var playerid = 1 setget set_playerid

var player

func set_player(_player):
    player = _player
    $InfoBox/CHBox/Hearts.set_player(player)
    $InfoBox/CHBox/CrestPool.set_crestpool(player.crestpool)

func set_opponent_title():
    $InfoBox/Title.text = "Opponent"

func update_crestpool():
    $InfoBox/CHBox/CrestPool.update_slots()

func set_playerid(_playerid):
    playerid = _playerid
    $InfoBox/CHBox/Hearts.set_player_hearts(playerid, 3)
