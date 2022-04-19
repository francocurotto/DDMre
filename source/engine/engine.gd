extends Reference

const Dicelib = preload("res://engine/dice/dicelib.gd")
const Player = preload("res://engine/player/player.gd")
const RollState = preload("res://engine/states/roll_state.gd")

var dicelib
var player1
var player2
var state

func _init():
	dicelib = Dicelib.new()
	player1 = Player.new(1, gen_randompool())
	player2 = Player.new(2, gen_randompool())
	state = RollState.new(player1, player2)

func update(cmd):
	"""
	Update engine with given command.
	"""
	state = state.update(cmd)

func gen_randompool():
	"""
	Creates a dice pool of random dice from the dicelib.
	"""
	var pool = []
	for i in 15:
		pool.append(dicelib.get_randdice())
	return pool
