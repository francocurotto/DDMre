extends "summon.gd"

# variables
var attack
var defense
var health

func _init(_card, _player).(_card, _player):
    attack = card.attack
    defense = card.defense
    health = card.health

# is functions
func is_monster():
    return true
