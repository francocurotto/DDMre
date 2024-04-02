extends RefCounted
## Library holding all available dice for the game.
##
## The library is created reading the dice database, a json file. The library
## can create a dicepool array from a file or chosen randomly.

#region preloads
const Dice = preload("res://engine/dice/dice.gd")
#endregion

#region variables
var dicelib_dict ## dice database read from the json file.
var rng          ## RNG object.
#endregion

#region builtin functions
func _init():
    dicelib_dict = Globals.read_jsonfile(Globals.LIBPATH)
    rng = RandomNumberGenerator.new()
    rng.randomize()
#endregion

#region public functions
## Create dicepool array from [param filepath] .json file. If [param filepath]
## is null, create a dicepool from random dice in the dice library.
func create_dicepool(filepath=null):
    # create indeces array
    var dice_indeces
    if filepath == null: # case no filepath, use random dice
        dice_indeces = create_random_dice_indeces()
    else: # case read dice from file in filepath
        dice_indeces = Globals.read_jsonfile(filepath)
    # create dicepool array
    var dicepool = []
    for diceidx in dice_indeces:
        var dice = Dice.new(dicelib_dict[str(diceidx)])
        dicepool.append(dice)
    return dicepool
#endregion

#region private functions
## Create an array of random dice indeces from the dice library.
func create_random_dice_indeces():
    var dice_indeces = []
    for _i in range(Globals.DICEPOOL_SIZE):
        dice_indeces.append(rng.randi_range(1,len(dicelib_dict)))
    return dice_indeces
#endregion
