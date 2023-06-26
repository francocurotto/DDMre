extends Reference

# preloads
const Dice = preload("res://engine/dice/dice.gd")

# variables
var dicelib_dict
var rng

func _init():
    dicelib_dict = Globals.read_jsonfile(Globals.LIBPATH)
    rng = RandomNumberGenerator.new()

# public functions
func create_dicepool(filepath=null):
    """
    Create dice pool list from json file. If filepath is null, create a 
    dicepool from random dice in the dice library.
    """
    # create index list
    var diceidx_list
    if filepath != null:
        diceidx_list = Globals.read_jsonfile(filepath)
    else:
        diceidx_list = create_random_diceidx_list()
    # create dice list
    var dicepool = []
    for diceidx in diceidx_list:
        var dice = Dice.new(dicelib_dict[str(diceidx)])
        dicepool.append(dicepool)
    return dicepool
    
# private fuctions
func create_random_diceidx_list():
    """
    Create a list of random dice index numbers from the dice library.
    """
    var diceidx_list = []
    for _i in range(15):
        diceidx_list.append(rng.randi_range(1,len(dicelib_dict)))
    return diceidx_list
