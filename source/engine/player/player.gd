extends RefCounted

# preloads
const CrestPool = preload("res://engine/player/crestpool.gd")
const MonsterLord = preload("res://engine/dungobj/monsterlord.gd")
const PlayerPathTile = preload("res://engine/dungeon/tiles/player_path_tile.gd")

# variables
var id
var opponent
var dicepool
var crestpool = CrestPool.new()
var monsterlord = MonsterLord.new(self)
var monsters = []
var graveyard = []

# signals
signal summon_destroyed(summon)

func _init(_id, _dicepool):
    id = _id
    dicepool = _dicepool

# public functions
func create_tile(y, x):
    """
    Create a path tile for the specific player with position (y,x).
    """
    var tile = PlayerPathTile.new(y, x, self)
    return tile

func create_ml_tile(y, x):
    """
    Create a path tile with the player's monster lord as content with 
    position (y,x).
    """
    var tile = create_tile(y, x)
    tile.content = monsterlord
    return tile

func summon_card(poolidx):
    """
    Summon card in position poolidx from the dicepool and return it. Also mark 
    dice as dimensioned.
    """
    var dice = dicepool[poolidx]
    dice.dimensioned = true
    var summon = dice.card.summon(self)
    return summon

# signals callbacks
func on_monster_destroyed(monster):
    """
    Destroy player monster.
    """
    monsters.erase(monster)
    graveyard.append(monster)

func on_hearts_depleted():
    """
    Lose duel as all hearts were destroyed.
    """
    Events.emit_signal("player_lost", self)

# is functions
func is_opponent_ml(dungobj):
    return dungobj.is_monster_lord() and dungobj.player != self
