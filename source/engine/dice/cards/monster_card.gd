extends "summon_card.gd"

# preloads
const summondict = {
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
    Return a summon object from card.
    """
    var monster = summondict[type].new(self, player)
    player.monsters.append(monster)
    monster.connect("monster_death", player, "on_monster_death")
    return monster

# "is" functions
func is_monster():
    return true
