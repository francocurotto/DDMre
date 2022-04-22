extends Reference

const CrestPool = preload("res://engine/player/crest_pool.gd")
#const MonsterLord = preload("res://engine/dungobj/monster_lord.gd")

var id
var dicepool
var crestpool = CrestPool.new()
#var monsterlord = MonsterLord.new()
var dimdice = []
var monsters = []
var items = []
var tiles = []

func _init(_id, _dicepool):
	id = _id
	dicepool = _dicepool
