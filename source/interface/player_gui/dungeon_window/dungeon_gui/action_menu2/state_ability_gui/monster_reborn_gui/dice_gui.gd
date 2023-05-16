extends HBoxContainer

# constants
const ROLLDICT = {"DRAGON"      : Color(1.2, 0.5, 0.5),
                  "SPELLCASTER" : Color(1.5, 1.5, 1.5),
                  "UNDEAD"      : Color(1.2, 1.2, 0.0),
                  "BEAST"       : Color(0.5, 1.2, 0.5),
                  "WARRIOR"     : Color(0.5, 0.5, 1.2),
                  "ITEM"        : Color(0.7, 0.7, 0.7)}

# variables
var dice

# onready variables
onready var dice_info = $Container/Margins/DiceInfo
onready var button = $Container/Button

# signals callbacks
signal dice_gui_info_button_pressed(card)

# setget functions
func set_dice(_dice):
    dice = _dice
    dice_info.set_dice(dice)
    color_buttons(dice.card)

# signals callbacks
func _on_InfoButton_pressed():
    emit_signal("dice_gui_info_button_pressed", dice.card)

# private functions
func color_buttons(card):
    button.modulate = ROLLDICT[card.type]
