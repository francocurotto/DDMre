extends RefCounted
## Dice used during the game to roll and dimension.
##
## A dice consists of a dice level, a card representing the summon the dice
## hold, and an array of 6 sides.

# constants
## Array of all monster types
const MONSTER_TYPES = ["DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR"]

# preloads
const MonsterCard = preload("res://engine/dice/cards/monster_card.gd")
const ItemCard = preload("res://engine/dice/cards/item_card.gd")
const Side = preload("res://engine/dice/side.gd")

# variables
var level ## Level of the dice. Equals to the level of the summon it holds.
var card  ## Summon card the dice hold that can be summoned during dimension.
var sides ## Array of 6 sides that can be rolled.
var dimensioned = false ## True if dice has been dimensioned, false otherwise.

func _init(dice_dict):
    level = dice_dict["LEVEL"]
    card = create_card(dice_dict)
    sides = create_sides(dice_dict["CRESTS"])

# public functions
## Roll the dice and randomly return one of the sides in the sides array.
func roll():
    var side = sides[randi() % sides.size()]
    return side

## Return the maximum number of crest multiplier among all dice sides of type 
## [param crest_type]. If dice has no side of type [param crest_type], return 
## 0.
func get_max_crests(crest_type):
    var max_crests = 0
    for side in sides:
        if side.crest.TYPE == crest_type:
            max_crests = max(max_crests, side.mult)
    return max_crests

# is functions
## Return true if dice has greater dice level than [param dice].
func greater_level(dice):
    return level > dice.level

## Return true if dice has a greater maximum crest multiplier of type 
## [param crest] than [param dice].
func greater_crest(dice, crest):
    return get_max_crests(crest) > dice.get_max_crests(crest)

## Return true if dice has greater dice level than [param dice]. If dice levels
## are equals, return true if dice has a greater maximum crest multiplier of
## type [param crest].
func greater_level_crest(dice, crest):
    if level != dice.level:
        return greater_level(dice)
    return greater_crest(dice, crest)

# private functions
## Create a card object with [param card_info] dictionary.
func create_card(card_info):
    if card_info["TYPE"] in MONSTER_TYPES:
        return MonsterCard.new(card_info)
    elif card_info["TYPE"] == "ITEM":
        return ItemCard.new(card_info)

## Create an array of dice sides given [param string], a string of crests from
## dice library database.
func create_sides(string):
    # prepare regex for side string separation
    var regex = RegEx.new()
    regex.compile("S|[MADTG][1-9]?") # regex for side detection
    
    # create list of side strings
    var side_strings = []
    for result in regex.search_all(string):
        side_strings.append(result.get_string())
    
    # then convert the side strings into side objects
    var side_array = []
    for side_string in side_strings:
        side_array.append(Side.new(side_string, level))
    return side_array
