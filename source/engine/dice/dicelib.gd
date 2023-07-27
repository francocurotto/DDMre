extends RefCounted

# preloads
const Dice = preload("res://engine/dice/dice.gd")

# variables
var dicelib_dict
var rng

func _init():
    dicelib_dict = Globals.read_jsonfile(Globals.LIBPATH)
    rng = RandomNumberGenerator.new()
    rng.randomize()

# public functions
func create_dicepool(filepath=null):
    """
    Create dice pool list from json file. If filepath is null, create a 
    dicepool from random dice in the dice library.
    """
    # create index list
    var diceidx_list
    if filepath == null: # case no filepath, use random dice
        diceidx_list = create_random_diceidx_list()
    else: # case read dice from file in filepath
        diceidx_list = Globals.read_jsonfile(filepath)
    # create dice list
    var dicepool = []
    #GODOT4: use array map
    for diceidx in diceidx_list:
        var dice = Dice.new(dicelib_dict[str(diceidx)])
        dicepool.append(dice)
    return dicepool
    
# private fuctions
func create_random_diceidx_list():
    """
    Create a list of random dice index numbers from the dice library.
    """
    var diceidx_list = []
    for _i in range(Globals.DICEPOOL_SIZE):
        diceidx_list.append(rng.randi_range(1,len(dicelib_dict)))
    return diceidx_list
