extends "summon_card.gd"

const summondict = {
    "DRAGON"      : preload("res://engine/dungobj/dragon.gd"),
    "SPELLCASTER" : preload("res://engine/dungobj/spellcaster.gd"),
    "UNDEAD"      : preload("res://engine/dungobj/undead.gd"),
    "BEAST"       : preload("res://engine/dungobj/beast.gd"),
    "WARRIOR"     : preload("res://engine/dungobj/warrior.gd")}

var attack
var defense
var health

func _init(cardinfo).(cardinfo):
    attack = cardinfo["ATTACK"]
    defense = cardinfo["DEFENSE"]
    health = cardinfo["HEALTH"]

func is_monster():
    return true

func summon(player):
    return summondict[type].new(self, player)
