extends Node

var dicelib

func _init():
    dicelib = load_dicelib()

func load_dicelib():
	return read_dicelibjson()

func read_dicelibjson():
	var file = File.new()
	file.open("res://LIBRARY.json", File.READ)
	var dicelibjson = parse_json(file.get_as_text())
	file.close()
	return dicelibjson
