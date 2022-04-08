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

func _init(playerid, player_dicepool):
	id = playerid
	dicepool = player_dicepool
