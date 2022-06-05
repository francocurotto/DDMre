extends "summon.gd"

var attack
var defense
var health

func _init(_card, _player).(_card, _player):
    attack = card.attack
    defense = card.defense
    health = card.health

func is_monster(): return true
