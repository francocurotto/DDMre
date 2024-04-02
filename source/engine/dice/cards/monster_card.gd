extends "summon_card.gd"
## Card of monster type.
##
## Summon card that represents a monster.

#region constants
const TYPE = "MONSTER"
#endregion

#region preloads
## Dictionary relating a name to a monster type. Used to create a monster card
## object from a string in the dice database.
const SUMMONDICT = {
    "DRAGON"      : preload("res://engine/dungobj/dragon.gd"),
    "SPELLCASTER" : preload("res://engine/dungobj/spellcaster.gd"),
    "UNDEAD"      : preload("res://engine/dungobj/undead.gd"),
    "BEAST"       : preload("res://engine/dungobj/beast.gd"),
    "WARRIOR"     : preload("res://engine/dungobj/warrior.gd")}
#endregion

#region variables
var attack  ## Monster base attack
var defense ## Monster base defense
var health  ## Monster base health
#endregion

#region builtin functions
func _init(cardinfo):
    super(cardinfo)
    attack = cardinfo["ATTACK"]
    defense = cardinfo["DEFENSE"]
    health = cardinfo["HEALTH"]
#endregion

#region public functions
## Summon a monster for [param player] from the monster card.
func summon(player):
    var monster = SUMMONDICT[type].new(self, player)
    player.monsters.append(monster)
    return monster
#endregion
