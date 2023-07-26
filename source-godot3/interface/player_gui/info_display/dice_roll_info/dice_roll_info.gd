extends MarginContainer
# constants
const COLORDICT = {"DRAGON"      : Color(1.0, 0.0, 0.0),
                   "SPELLCASTER" : Color(0.7, 0.7, 0.7),
                   "UNDEAD"      : Color(1.0, 1.0, 0.0),
                   "BEAST"       : Color(0.0, 1.0, 0.0),
                   "WARRIOR"     : Color(0.0, 0.0, 1.0),
                   "ITEM"        : Color(0.3, 0.3, 0.3)}

# onready varibles
onready var dice_icon = $DiceIcon
onready var summon_icon = $SummonMargin/SummonIcon

#setget functions
func set_dice(dice):
    dice_icon.modulate = COLORDICT[dice.card.type]
    summon_icon.texture = load("res://art/icons/TYPE_" + dice.card.type + ".png")

func remove_dice():
    dice_icon.modulate = Color(1.0, 1.0, 1.0)
    summon_icon.texture = null
