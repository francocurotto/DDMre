tool
extends HBoxContainer

export (int, 1, 2) var player = 1 setget set_player
export (int, 3) var hearts = 3 setget set_hearts

const heartdict = {1 : "res://art/icons/HEART_RED.png",
                   2 : "res://art/icons/HEART_BLUE.png"}

func set_player_hearts(_player, _hearts):
    for i in range(hearts):
        get_child(i).texture = load(heartdict[_player])
    for i in range(get_child_count(), hearts, -1):
        get_child(i-1).texture = load("res://art/icons/HEART_BLACK.png")

func set_player(_player):
    player = _player
    set_player_hearts(_player, hearts)

func set_hearts(_hearts):
    hearts = _hearts
    set_player_hearts(player, _hearts)
