extends Reference

const Dice = preload("res://engine/dice/dice.gd")
const Player = preload("res://engine/player/player.gd")
const RollState = preload("res://engine/states/roll_state.gd")

var dicelib
var player1
var player2
var state

func _init():
	dicelib = load_dicelib()
	player1 = Player.new(1, gen_randompool())
	player2 = Player.new(2, gen_randompool())
	state = RollState.new(player1, player2)

func update(cmd):
	"""
	Update engine with given command.
	"""
	state.update(cmd)

func load_dicelib():
	"""
	Creates dice library dictionary from LIBRARY.json.
	"""
	dicelib = {}
	var jsonlib = read_jsonlib()
	for key in jsonlib:
		dicelib[int(key)] = Dice.new(int(key), jsonlib[key])
	return dicelib

func read_jsonlib():
	"""
	Reads LIBRARY.json with dice info.
	"""
	var file = File.new()
	file.open("res://LIBRARY.json", File.READ)
	var jsonlib = parse_json(file.get_as_text())
	file.close()
	return jsonlib

func gen_randompool():
	"""
	Creates a dice pool of random dice from the dicelib.
	"""
	var pool = []
	for i in 15:
		var dice = dicelib.values()[randi() % dicelib.size()]
		pool.append(dice)
	return pool
