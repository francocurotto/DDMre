extends Reference
const MonsterCard = preload("res://engine/dice/cards/monster_card.gd")
const ItemCard = preload("res://engine/dice/cards/item_card.gd")
const Side = preload("res://engine/dice/crests/side.gd")
const monstertypes = ["DRAGON", "SPELLCASTER", "UNDEAD",
    "BEAST", "WARRIOR"]

var id
var level
var card
var sides

func _init(diceid, dicedict):
    id = diceid
    level = dicedict["LEVEL"]
    card = create_card(dicedict)
    sides = create_sides(dicedict["CRESTS"], level)

func create_card(cardinfo):
    """
    Creates card object with cardinfo dictionary.
    """
    if cardinfo["TYPE"] in monstertypes:
        return MonsterCard(cardinfo)
    elif cardinfo["TYPE"] == "ITEM":
        return ItemCard(cardinfo)

func create_sides(string, level):
    """
    Creates a list of dice sides given a string of crests from
    dice library file.
    """
    # get crest characters from crest dict
    crestchars = Side.crestdict.keys()

    # first break the string into a list of side strings
    sidestrings = []
    for char in string:
        if char in crestchars:
            sidestrings.append(char)
            if char == "S": # add level as multiplier
                sidestrings[-1] += str(level)
        else: # expected to be a digit
            sidestrings[-1] += char

    # then convert the side strings into side objects
    sidelist = []
    for sidestring in sidestrings:
        sidelist.append(Side(sidestring))

    return sidelist
