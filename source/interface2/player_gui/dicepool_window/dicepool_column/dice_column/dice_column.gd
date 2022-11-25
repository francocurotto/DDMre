extends HBoxContainer

# constants
const ROLLDICT = {"DRAGON"      : Color(1.2, 0.5, 0.5),
                  "SPELLCASTER" : Color(1.5, 1.5, 1.5),
                  "UNDEAD"      : Color(1.2, 1.2, 0.0),
                  "BEAST"       : Color(0.5, 1.2, 0.5),
                  "WARRIOR"     : Color(0.5, 0.5, 1.2),
                  "ITEM"        : Color(0.7, 0.7, 0.7)}
const ENABLED_COLOR = Color(1.0, 1.0, 1.0)
const DISABLED_COLOR = Color(0.3, 0.3, 0.3)

# variables
var dice
var selected setget , is_selected
var dimensioned setget , is_dimensioned

# onready variables
onready var diceline = $DiceContainer/Margins/DiceLine
onready var dice_roll_button = $DiceContainer/DiceRollButton
onready var dice_dim_button = $DiceContainer/DiceDimButton
onready var info_button = $InfoButton

# signals
signal dice_roll_button_toggled
signal info_button_pressed(card)

func _ready():
    # signal connections
    info_button.connect("info_button_pressed", self, "on_info_button_pressed")

# setget functions
func set_dice(_dice):
    dice = _dice
    diceline.set_dice(dice)
    color_buttons(dice.card)
    info_button.set_card(dice.card)

func enable_roll():
    dice_roll_button.disabled = false
    modulate = ENABLED_COLOR

func disable_roll():
    dice_roll_button.disabled = true
    modulate = DISABLED_COLOR

func switch_to_dim():
    dice_roll_button.visible = false
    dice_dim_button.visible = true
    modulate = ENABLED_COLOR

func is_selected():
    return dice_roll_button.pressed

func is_dimensioned():
    return dice.dimensioned

# signals callbacks
func _on_DiceRollButton_toggled(_button_pressed):
    emit_signal("dice_roll_button_toggled")

func on_info_button_pressed(card):
    emit_signal("info_button_pressed", card)

# private functions
func color_buttons(card):
    dice_roll_button.modulate = ROLLDICT[card.type]
    dice_dim_button.modulate = ROLLDICT[card.type]
