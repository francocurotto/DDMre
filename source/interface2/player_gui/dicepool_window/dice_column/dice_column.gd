extends HBoxContainer

# constants
const ROLLDICT = {"DRAGON"      : Color(1.2, 0.5, 0.5, 1.0), 
                  "SPELLCASTER" : Color(1.5, 1.5, 1.5, 1.0),
                  "UNDEAD"      : Color(1.2, 1.2, 0.0, 1.0),
                  "BEAST"       : Color(0.5, 1.2, 0.5, 1.0),
                  "WARRIOR"     : Color(0.5, 0.5, 1.2, 1.0),
                  "ITEM"        : Color(0.7, 0.7, 0.7, 1.0)}
const ENABLE_COLOR = Color(1.0, 1.0, 1.0, 1.0)
const DISABLE_COLOR = Color(0.3, 0.3, 0.3, 1.0)

# onready variables
onready var diceline = $DiceContainer/Margins/DiceLine
onready var roll_button = $DiceContainer/RollButton
onready var info_button = $InfoButton

# signals
signal info_button_pressed(card)

func _ready():
    # signal connections
    info_button.connect("info_button_pressed", self, "on_info_button_pressed")

# setget functions
func set_dice(dice):
    diceline.set_dice(dice)
    color_roll_button(dice.card)
    info_button.set_card(dice.card)

# signals callbacks
func on_info_button_pressed(card):
    emit_signal("info_button_pressed", card)

# private functions
func color_roll_button(card):
    roll_button.modulate = ROLLDICT[card.type]
