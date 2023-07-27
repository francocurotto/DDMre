extends RefCounted

# constants
const MONSTER_TYPES = ["DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR"]

# preloads
const MonsterCard = preload("res://engine/dice/cards/monster_card.gd")
const ItemCard = preload("res://engine/dice/cards/item_card.gd")
const Side = preload("res://engine/dice/side.gd")

# variables
var level
var card
var sides
var dimensioned = false

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
    return side

# private functions
func create_card(cardinfo):
    """
    Create card object with cardinfo dictionary.
    """
    if cardinfo["TYPE"] in MONSTER_TYPES:
        return MonsterCard.new(cardinfo)
    elif cardinfo["TYPE"] == "ITEM":
        return ItemCard.new(cardinfo)

func create_sides(string):
    """
    Create a list of dice sides given a string of crests from
    dice library file.
    """
    # prepare regex for side string separation
    var regex = RegEx.new()
    regex.compile("S|[MADTG][1-9]?") # regex for side detection
    
    # create list of side strings
    var side_strings = []
    for result in regex.search_all(string):
        side_strings.append(result.get_string())
    
    # then convert the side strings into side objects
    var side_list = []
    for side_string in side_strings:
        side_list.append(Side.new(side_string, level))
    return side_list
