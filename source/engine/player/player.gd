extends Reference

const CrestPool = preload("res://engine/player/crest_pool.gd")
const MonsterLord = preload("res://engine/dungobj/monster_lord.gd")
const PathTile = preload("res://engine/dungeon/tiles/path_tile.gd")

var id
var dicepool
var crestpool = CrestPool.new()
var monsterlord = MonsterLord.new(self)
var dimdice = []
var monsters = []
var items = []
var tiles = []

func _init(_id, _dicepool):
    id = _id
    dicepool = _dicepool

func create_tile():
    """
    Creates a path tile for the specific player.
    """
    var tile = PathTile.new(self)
    tiles.append(tile)
    return tile

func create_ml_tile():
    """
    Creates a path tile with the player's monster lord as content.
    """
    var tile = create_tile()
    tile.content = monsterlord
    return tile

func summon_card(idx):
    """
    Summon card in position idx from the dicepool.
    """
    return dicepool[idx].card.summon(self)
