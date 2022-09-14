extends Reference

# preloads
const Dice = preload("res://engine/dice/dice.gd")

# variables
var dict

func _init():
    dict = read_jsonfile(Globals.LIBPATH)

# public functions
func create_dicepool(filepath):
    """
    Create dice pool list from json file.
    """
    var indexlist = read_jsonfile(filepath)
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
func read_jsonfile(filepath):
    """
    Read json file and return it as a dictionary.
    """
    var file = File.new()
    file.open(filepath, File.READ)
    var jsondict = parse_json(file.get_as_text())
    file.close()
    return jsondict

func create_dice(id):
    """
    Create dice object from dictionary and return it. 
    """
    return Dice.new(id, dict[str(id)])

func create_randdice():
    """
    Return a random dice in the library.
    """
    return create_dice(randi() % dict.size() + 1)
