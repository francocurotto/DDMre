extends "playerobj.gd"

# variables
var card

func _init(_card, _player).(_player):
    card = _card

# "is" functions
func is_summon():
    return true
