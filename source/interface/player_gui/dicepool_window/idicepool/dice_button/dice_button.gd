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
var roll_visible setget , is_roll_visible
var roll_selected setget , is_roll_selected
var dim_visible setget , is_dim_visible
var dim_selected setget , is_dim_selected
var dimensioned setget , is_dimensioned

# onready variables
onready var diceinfo = $DiceContainer/Margins/DiceInfo
onready var dice_roll_button = $DiceContainer/DiceRollButton
onready var dice_dim_button = $DiceContainer/DiceDimButton
onready var info_button = $InfoButton

# signals
signal dice_roll_button_toggled
signal dice_dim_button_pressed
signal dice_dim_button_released
signal info_button_pressed(card)

func _ready():
    # signal connections
    info_button.connect("info_button_pressed", self, "on_info_button_pressed")

# setget functions
func set_dice(_dice):
    dice = _dice
    diceinfo.set_dice(dice)
    color_buttons(dice.card)
    info_button.set_card(dice.card)

func is_roll_visible():
    return dice_roll_button.visible

func is_roll_selected():
    return dice_roll_button.pressed

func is_dim_visible():
    return dice_dim_button.visible

func is_dim_selected():
    return dice_dim_button.pressed and not dice_dim_button.disabled

func is_dimensioned():
    return dice.dimensioned

# public functions
func enable_roll():
    switch_to_roll()
    dice_roll_button.disabled = false
    modulate = ENABLED_COLOR

func disable_roll():
    switch_to_roll()
    dice_roll_button.disabled = true
    modulate = DISABLED_COLOR

func release_roll():
    dice_roll_button.set_pressed_no_signal(false)

func enable_dim():
    switch_to_dim()
    dice_dim_button.disabled = false
    modulate = ENABLED_COLOR

func disable_dim():
    switch_to_dim()
    dice_dim_button.disabled = true
    modulate = DISABLED_COLOR

# signals callbacks
func _on_DiceRollButton_toggled(_button_pressed):
    emit_signal("dice_roll_button_toggled")

func _on_DiceDimButton_toggled(button_pressed):
    if button_pressed:
        emit_signal("dice_dim_button_pressed", self)
    else:
        emit_signal("dice_dim_button_released")

func on_info_button_pressed(card):
    emit_signal("info_button_pressed", card)

# private functions
func color_buttons(card):
    dice_roll_button.modulate = ROLLDICT[card.type]
    dice_dim_button.modulate = ROLLDICT[card.type]

func switch_to_roll():
    dice_roll_button.visible = true
    dice_dim_button.visible = false

func switch_to_dim():
    dice_roll_button.visible = false
    dice_dim_button.visible = true