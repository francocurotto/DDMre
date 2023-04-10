extends Reference

# preloads
const CrestPool = preload("res://engine/player/crestpool.gd")
const MonsterLord = preload("res://engine/dungobj/monster_lord.gd")
const PathTile = preload("res://engine/dungeon/tiles/path_tile.gd")
const namedict = {1: "BLUE", 2: "RED"}

# variables
var id
var name
var opponent
var dicepool
var crestpool = CrestPool.new()
var monsterlord = MonsterLord.new(self)
var monsters = []
var items = [] # unused?
var graveyard = []
var tiles = []

# signals
signal summon_dead(summon)

func _init(_id, _dicepool):
    id = _id
    name = namedict[id]
    dicepool = _dicepool

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
    tile.set_content(monsterlord)
    return tile

func summon_card(idx):
    """
    Summon card in position idx from the dicepool.
    """
    var dice = dicepool[idx]
    dice.dimensioned = true
    var summon = dicepool[idx].card.summon(self)
    Events.emit_signal("new_summon", summon)
    return summon

func on_monster_dead(monster):
    """
    Remove monster from list, add to graveyard, and alert dungeon for removal.
    """
    monsters.erase(monster)
    graveyard.append(monster)
    emit_signal("summon_dead", monster)

func on_item_dead(item):
    """
    Remove item from list, and alert dungeon for removal.
    """
    items.erase(item)
    emit_signal("summon_dead", item)

func on_hearts_depleted():
    Events.emit_signal("player_lost", self)
