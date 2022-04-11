extends Reference

const Dice = preload("res://engine/dice/dice.gd")

var dict = {}

func _init():
	var jsonlib = read_jsonlib()
	for key in jsonlib:
		dict[int(key)] = Dice.new(int(key), jsonlib[key])

func read_jsonlib():
	"""
	Reads LIBRARY.json with dice info.
	"""
	var file = File.new()
	file.open("res://LIBRARY.json", File.READ)
	var jsonlib = parse_json(file.get_as_text())
	file.close()
	return jsonlib

func get_randdice():
	"""
	Returns a random dice in the library.
	"""
	return dict.values()[randi() % dict.size()]
