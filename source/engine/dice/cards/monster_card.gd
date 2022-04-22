extends "summon_card.gd"

var attack
var defense
var health

func _init(cardinfo).(cardinfo):
	attack = cardinfo["ATTACK"]
	defense = cardinfo["DEFENSE"]
	health = cardinfo["HEALTH"]

func is_monster():
	return true
