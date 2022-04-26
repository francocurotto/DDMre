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

func create_dicepool(filepath):
    """
    Create dice pool list from json file.
    """
    var file = File.new()
    file.open(filepath, File.READ)
    var indexlist = parse_json(file.get_as_text())
    file.close()
    var dicelist = []
    for i in indexlist:
        dicelist.append(create_dice(i))
    return dicelist

func create_dice(index):
    """
    Creates dice object from dictionary and return it. 
    """
    return Dice.new(index, dict[str(index)])

func create_randdice():
    """
    Returns a random dice in the library.
    """
    return create_dice(randi() % dict.size() + 1)

func create_randpool():
    """
    Creates a random dice pool.
    """
    var dicelist = []
    for _i in range(15):
        dicelist.append(create_randdice())
    return dicelist
