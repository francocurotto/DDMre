extends RefCounted
## Engine that controls the game logic of a duel between two players.
##
## The engine receives commands in the form of dictionaries and update the 
## state of the duel. It also initialize each players dicepools, and  
## optionally the dungeon layout.

# preloads
const Dicelib = preload("res://engine/dice/dicelib.gd")
const Player = preload("res://engine/player/player.gd")
const Dungeon = preload("res://engine/dungeon/dungeon.gd")
const RollState = preload("res://engine/states/roll_state.gd")
const Checks = preload("res://engine/checks.gd")

# variables
var dicelib   ## Dice library object used to generate the players dicepools
var player1   ## Object for Player 1
var player2   ## Object for Player 2
var state     ## Object that represent the current state of the engine
var turn = 1  ## Turn count

func _init(dungpath=null, pool1path=null, pool2path=null):
	# create dicelib
	dicelib = Dicelib.new()
	# objects for state
	player1 = Player.new(1, dicelib.create_dicepool(pool1path))
	player2 = Player.new(2, dicelib.create_dicepool(pool2path))
	player1.opponent = player2
	player2.opponent = player1
	var dungeon = Dungeon.new()
	# create initial state
	state = RollState.new(player1, player2, dungeon)
	# set init state from file
	set_init_state(dungpath)

# public functions
## Update engine with given command [param cmddict]. The engine state is 
## updated and the turn count is increased if needeed.
func update(cmddict):
	# get new state info
	var new_state = state.update(cmddict)
	var state_update = new_state != state
	var next_turn = state.NAME == "DUNGEON" and new_state.NAME == "ROLL"
	# perform the update
	state = new_state
	if next_turn:
		turn += 1
		Events.next_turn.emit(state.player, turn)
	if state_update:
		Events.state_update.emit(state.NAME)

# private functions
## Set initial state of the engine as defined in the JSON file 
## [param dungpath]. It is mainly use to define the initial dungeon layout, but 
## it can also be used for debugging purposes like defining inital summons, 
## crests, etc.
func set_init_state(dungpath):
	# if dungpath is null, use default
	if dungpath == null:
		dungpath = Globals.DUNGPATH
	# convert json to dict
	var initdict = Globals.read_jsonfile(dungpath)
	# go through every key in dict
	for initkey in initdict:
		match initkey:
			"DUNGEON"  : set_init_dungeon(initdict["DUNGEON"])
			"SUMMONS1" : set_init_summons(player1, initdict["SUMMONS1"])
			"SUMMONS2" : set_init_summons(player2, initdict["SUMMONS2"])
			"VORTEX"   : set_init_vortex(initdict["VORTEX"])
			"CRESTS1"  : set_init_crests(player1, initdict["CRESTS1"])
			"CRESTS2"  : set_init_crests(player2, initdict["CRESTS2"])
			"HEARTS1"  : set_init_hearts(player1, initdict["HEARTS1"])
			"HEARTS2"  : set_init_hearts(player2, initdict["HEARTS2"])

## Set the initial dungeon layout according to [param layout] array.
func set_init_dungeon(layout):
	if Checks.check_dungeon_layout(layout):
		state.dungeon.set_layout(player1, player2, layout)

## Set the initial summons in dungeon for [param player] according to 
## [param summons] array.
func set_init_summons(player, summons):
	for summon_dict in summons:
		if Checks.check_summon_dict(summon_dict):
			var pos = str_to_pos(summon_dict["POS"])
			var diceidx = summon_dict["DICE"]-1 # convert diceidx to 0-indexing
			state.dungeon.place_summon(player, pos, diceidx)
	
## Set the initial vorteces in dungeon according to [param vorteces] array.
func set_init_vortex(vorteces):
	for vortex in vorteces:
		if Checks.check_pos_string(vortex):
			var pos = str_to_pos(vortex)
			state.dungeon.place_vortex(pos)

## Set the initial crests for [param player] according to [param crests] array.
func set_init_crests(player, crests):
	if Checks.check_crests_dict(crests):
		for crest in crests:
			player.crestpool.set_crest(crest, crests[crest])

## Set the initial hearts for [param player] to value [param hearts].
func set_init_hearts(player, hearts):
	if Checks.check_hearts_int(hearts):
		player.monster_lord.set_hearts(hearts)

## Convert position [param string] into a Vector2i position.
## For example,"a1" is converted to (0,0)
func str_to_pos(string):
	return Vector2i(string.unicode_at(0)-97, int(string.substr(1))-1)
