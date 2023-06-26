extends Reference

# constants
const CRESTCHARS = ["S", "M", "A", "D", "G", "T"]

# preloads
const MonsterCard = preload("res://engine/dice/cards/monster_card.gd")
const ItemCard = preload("res://engine/dice/cards/item_card.gd")
const Side = preload("res://engine/dice/crests/side.gd")

# variables
var level
var card
var sides
var dimensioned = false

# signals
signal rolled(side)

func _init(dice_dict):
    level = dice_dict["LEVEL"]
    card = create_card(dice_dict)
    sides = create_sides(dice_dict["CRESTS"])

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
    if cardinfo["TYPE"] in Globals.MONSTERTYPES:
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
        if chr in CRESTCHARS:
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
