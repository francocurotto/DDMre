extends RefCounted
## Player that participates in duel.
##
## The player manages all the information available to one of the participant
## of the duel. It can also create tiles, monster lords and summons for itself.

#region preloads
const CrestPool = preload("res://engine/player/crestpool.gd")
const MonsterLord = preload("res://engine/dungobj/monster_lord.gd")
const PlayerPathTile = preload("res://engine/dungeon/tiles/player_path_tile.gd")
#endregion

#region variables
var id       ## Player ID, either 1 or 2
var opponent ## Refenrece to opponent
var dicepool ## Array of dice to use in duel
var crestpool = CrestPool.new() ## Pool of crests acquired during the duel
var monster_lord = MonsterLord.new(self) ## Player representation in dungeon
var monsters = []  ## Array of player monsters in dungeon
var graveyard = [] ## Array of destroyed player monsters
#endregion

#region
func _init(_id, _dicepool):
    id = _id
    dicepool = _dicepool
#endregion

#region public functions
## Create and return a player path tile expected to be located at position
## ([param y],[param x]).
func create_tile(y, x):
    var tile = PlayerPathTile.new(y, x, self)
    return tile

## Create and return a player path tile expected to be located at position
## ([param y],[param x]), and add to that tile content the player monster 
## lord.
func create_ml_tile(y, x):
    var tile = create_tile(y, x)
    tile.content = monster_lord
    return tile

## Summon the card from the dicepool at position [param diceidx], and mark the
## corresponding dice as dimensioned. Return the resulting summon.
func summon_card(diceidx):
    var dice = dicepool[diceidx]
    dice.dimensioned = true
    var summon = dice.card.summon(self)
    return summon

## Remove monster from monsters array, and add monster to graveyard array.
## Used when a monster is destroyed in dungeon.
func remove_monster(monster):
    monsters.erase(monster)
    graveyard.append(monster)
#endregion
