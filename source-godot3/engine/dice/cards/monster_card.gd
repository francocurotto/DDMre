extends "summon_card.gd"

# constants
const TYPE = "MONSTER"

# preloads
const summon_dict = {
    "DRAGON"      : preload("res://engine/dungobj/dragon.gd"),
    "SPELLCASTER" : preload("res://engine/dungobj/spellcaster.gd"),
    "UNDEAD"      : preload("res://engine/dungobj/undead.gd"),
    "BEAST"       : preload("res://engine/dungobj/beast.gd"),
    "WARRIOR"     : preload("res://engine/dungobj/warrior.gd")}

# variables
var attack
var defense
var health

func _init(cardinfo).(cardinfo):
    attack = cardinfo["ATTACK"]
    defense = cardinfo["DEFENSE"]
    health = cardinfo["HEALTH"]

# public functions
func summon(player):
    """
    Return a summon monster from card.
    """
    var monster = summon_dict[type].new(self, player)
    player.monsters.append(monster)
    return monster
