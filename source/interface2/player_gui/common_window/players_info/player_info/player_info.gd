tool
extends HBoxContainer

# export variables
export (int, 1, 2) var playerid = 1 setget set_playerid

# setget functions
func set_player(_player):
    if has_node("Hearts"):
        $Hearts.set_player(_player)

func set_playerid(_playerid):
    playerid = _playerid
    if has_node("Hearts"):
        $Hearts.set_playerid(_playerid)

