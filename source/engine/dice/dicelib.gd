extends Reference

# preloads
const Dice = preload("res://engine/dice/dice.gd")

# variables
var dict = {}

func _init():
    dict = read_jsonlib()

# public functions
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

func create_randpool():
    """
    Create a random dice pool.
    """
    var dicelist = []
    for _i in range(15):
        dicelist.append(create_randdice())
    return dicelist

# private functions
func read_jsonlib():
    """
    Read LIBRARY.json with dice info.
    """
    var file = File.new()
    file.open(Globals.LIBPATH, File.READ)
    var jsonlib = parse_json(file.get_as_text())
    file.close()
    return jsonlib

func create_dice(index):
    """
    Create dice object from dictionary and return it. 
    """
    return Dice.new(index, dict[str(index)])

func create_randdice():
    """
    Return a random dice in the library.
    """
    return create_dice(randi() % dict.size() + 1)
