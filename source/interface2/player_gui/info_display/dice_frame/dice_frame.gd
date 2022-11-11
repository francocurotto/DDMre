extends MarginContainer
# constants
const COLORDICT = {"DRAGON"      : Color(1.2, 0.5, 0.5), 
                   "SPELLCASTER" : Color(1.5, 1.5, 1.5),
                   "UNDEAD"      : Color(1.2, 1.2, 0.0),
                   "BEAST"       : Color(0.5, 1.2, 0.5),
                   "WARRIOR"     : Color(0.5, 0.5, 1.2),
                   "ITEM"        : Color(0.7, 0.7, 0.7)}

# variables
var idx
var dice

# onready varibles
onready var dice_icon = $DiceIcon
onready var summon_icon = $SummonMargin/SummonIcon

#setget functions
func set_dice(_idx, _dice):
    idx = _idx
    dice = _dice
    dice_icon.modulate = COLORDICT[dice.card.type]
    summon_icon.texture = load("res://art/icons/TYPE_" + dice.card.type + ".png")

func remove_dice():
    dice_icon.modulate = Color(1.0, 1.0, 1.0)
    summon_icon.texture = null

# public variables
func is_empty():
    return summon_icon.texture == null
