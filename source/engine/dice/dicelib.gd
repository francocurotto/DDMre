extends Reference

const Dice = preload("res://engine/dice/dice.gd")

var dict = {}

func _init():
    dict = read_jsonlib()

func read_jsonlib():
    """
    Reads LIBRARY.json with dice info.
    """
    var file = File.new()
    file.open(Globals.LIBPATH, File.READ)
    var jsonlib = parse_json(file.get_as_text())
    file.close()
    return jsonlib

func get_randdice():
    """
    Returns a random dice in the library.
    """
    return create_dice(randi() % dict.size() + 1)

func create_dice(index):
    """
    Creates dice object from dictionary and return it. 
    """
    return Dice.new(index, dict[str(index)])
