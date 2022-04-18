tool
extends PanelContainer

export (bool) var random_pool setget set_random_pool
export (int, 1, 2) var player = 1 setget set_player

func _ready():
    $PIBBox/IBBox/OpponentInfo.set_opponent_title()

func set_random_pool(_bool):
    $PIBBox/Dicepool.set_random_pool(_bool)

func set_player(_player):
    player = _player
    var opponent = player%2 + 1
    $PIBBox/IBBox/PlayerInfo.set_player(player)
    $PIBBox/IBBox/OpponentInfo.set_player(opponent)
