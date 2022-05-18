tool
extends PanelContainer

export (int, 1, 2) var playerid = 1 setget set_playerid

func set_player(player):
    $InfoBox/CHBox/Hearts.set_player_hearts(player.id, player.monsterlord.hearts)
    $InfoBox/CHBox/CrestPool.set_pool(player.crestpool.slots)

func set_opponent_title():
    $InfoBox/Title.text = "Opponent"

func update_roll(player):
    $InfoBox/CHBox/CrestPool.set_pool(player.crestpool.slots)

func set_playerid(_playerid):
    playerid = _playerid
    $InfoBox/CHBox/Hearts.set_player_hearts(playerid, 3)
