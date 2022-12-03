extends Reference

# preloads
const CrestPool = preload("res://engine/player/crestpool.gd")
const MonsterLord = preload("res://engine/dungobj/monster_lord.gd")
const PathTile = preload("res://engine/dungeon/tiles/path_tile.gd")
const namedict = {1: "BLUE", 2: "RED"}

# variables
var id
var name
var dicepool
var crestpool = CrestPool.new()
var monsterlord = MonsterLord.new(self)
var monsters = []
var items = []
var targets = [monsterlord]
var tiles = []

# signals
signal monster_death(monster)
signal player_lost(player)

func _init(_id, _dicepool):
    id = _id
    name = namedict[id]
    dicepool = _dicepool
    monsterlord.connect("hearts_depleted", self, "on_hearts_depleted")

# public functions
func create_tile(i, j):
    """
    Create a path tile for the specific player.
    """
    var tile = PathTile.new(i, j, self)
    tiles.append(tile)
    return tile

func create_ml_tile(i, j):
    """
    Create a path tile with the player's monster lord as content.
    """
    var tile = create_tile(i, j)
    tile.content = monsterlord
    return tile

func summon_card(idx):
    """
    Summon card in position idx from the dicepool.
    """
    var dice = dicepool[idx]
    dice.dimensioned = true
    return dicepool[idx].card.summon(self)

# signals callback
func on_monster_death(monster):
    monsters.erase(monster)
    emit_signal("monster_death", monster)

func on_hearts_depleted():
    Events.emit_signal("player_lost", self)
