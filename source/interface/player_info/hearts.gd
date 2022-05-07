tool
extends HBoxContainer

export (int, 1, 2) var playerid = 1 setget set_playerid
export (int, 3) var hearts = 3 setget set_hearts

const HEARTDICT = {1 : "res://art/icons/HEART_BLUE.png",
                   2 : "res://art/icons/HEART_RED.png"}

func set_player_hearts(_playerid, _hearts):
    for i in range(_hearts):
        get_child(i).texture = load(HEARTDICT[_playerid])
    for i in range(get_child_count(), _hearts, -1):
        get_child(i-1).texture = load("res://art/icons/HEART_BLACK.png")

func set_playerid(_playerid):
    playerid = _playerid
    set_player_hearts(_playerid, hearts)

func set_hearts(_hearts):
    hearts = _hearts
    set_player_hearts(playerid, _hearts)
