extends "summon_card.gd"
## Card of monster type.
##
## Summon card that represents a monster.

# constants
const TYPE = "MONSTER"

# preloads
const DRAGON       = preload("res://engine/dungobj/dragon.gd")
const SPELLCASTER  = preload("res://engine/dungobj/spellcaster.gd")
const UNDEAD       = preload("res://engine/dungobj/undead.gd")
const BEAST        = preload("res://engine/dungobj/beast.gd")
const WARRIOR      = preload("res://engine/dungobj/warrior.gd")

# preloads
## Dictionary relating a name to a monster type. Used to create a monster card
## object from a string in the dice database.
const SUMMONDICT = {
    "DRAGON"      : DRAGON,
    "SPELLCASTER" : SPELLCASTER,
    "UNDEAD"      : UNDEAD,
    "BEAST"       : BEAST,
    "WARRIOR"     : WARRIOR}

# variables
var attack  ## Monster base attack
var defense ## Monster base defense
var health  ## Monster base health

func _init(cardinfo):
    super(cardinfo)
    attack = cardinfo["ATTACK"]
    defense = cardinfo["DEFENSE"]
    health = cardinfo["HEALTH"]

# public functions
## Summon a monster for player [param player] from the monster card.
func summon(player):
    var monster = SUMMONDICT[type].new(self, player)
    player.monsters.append(monster)
    return monster
