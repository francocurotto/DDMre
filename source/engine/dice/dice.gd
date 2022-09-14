extends Reference

# preloads
const MonsterCard = preload("res://engine/dice/cards/monster_card.gd")
const ItemCard = preload("res://engine/dice/cards/item_card.gd")
const Side = preload("res://engine/dice/crests/side.gd")

# variables
var id
var level
var card
var sides

# signals
signal rolled(side)

func _init(_id, dicedict):
    id = _id
    level = dicedict["LEVEL"]
    card = create_card(dicedict)
    sides = create_sides(dicedict["CRESTS"])

# public functions
func roll():
    """
    Roll the dice and produce a side.
    """
    var side = sides[randi() % sides.size()]
    emit_signal("rolled", side)
    return side

# private functions
func create_card(cardinfo):
    """
    Create card object with cardinfo dictionary.
    """
    if cardinfo["TYPE"] in Globals.TYPES:
        return MonsterCard.new(cardinfo)
    elif cardinfo["TYPE"] == "ITEM":
        return ItemCard.new(cardinfo)

func create_sides(string):
    """
    Create a list of dice sides given a string of crests from
    dice library file.
    """
    # first break the string into a list of side strings
    var sidestrings = []
    for chr in string:
        if chr in Globals.CRESTCHARS:
            sidestrings.append(chr)
            if chr == "S": # add level as multiplier
                sidestrings[-1] += str(level)
        else: # expected to be a digit
            sidestrings[-1] += chr
    # then convert the side strings into side objects
    var sidelist = []
    for sidestring in sidestrings:
        sidelist.append(Side.new(sidestring))
    return sidelist
