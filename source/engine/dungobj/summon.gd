extends "playerobj.gd"

var card

func _init(_card, _player).(_player):
    card = _card

func is_summon(): return true
