extends Reference

const Dice = preload("res://engine/dice/dice.gd")

var dicelib

func _init():
    dicelib = load_dicelib()

func load_dicelib():
    """
    Creates dice library dictionary from LIBRARY.json.
    """
    var dicelib = {}
    var jsonlib = read_jsonlib()
    for key in jsonlib:
        dicelib[key] = Dice.new(key, jsonlib[key])
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
