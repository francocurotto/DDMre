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
var index
var dice
var roll_visible setget , is_roll_visible
var roll_selected setget , is_roll_selected
var dim_visible setget , is_dim_visible
var dim_selected setget , is_dim_selected
var dimensioned setget , is_dimensioned

# onready variables
onready var dice_info = $Container/Margins/DiceInfo
onready var roll_button = $Container/RollButton
onready var dim_button = $Container/DimButton
onready var info_button = $InfoButton

# signals
signal dice_gui_roll_button_toggled
signal dice_gui_dim_button_pressed
signal dice_gui_dim_button_released
signal dice_gui_info_button_pressed(card)

# setget functions
func set_dice(_dice):
    dice = _dice
    dice_info.set_dice(dice)
    color_buttons(dice.card)

func is_roll_visible():
    return roll_button.visible

func is_roll_selected():
    return roll_button.pressed

func is_dim_visible():
    return dim_button.visible

func is_dim_selected():
    return dim_button.pressed and not dim_button.disabled

func is_dimensioned():
    return dice.dimensioned

# public functions
func enable_roll():
    switch_to_roll()
    roll_button.disabled = false
    modulate = ENABLED_COLOR

func disable_roll():
    switch_to_roll()
    roll_button.disabled = true
    modulate = DISABLED_COLOR

func release_roll():
    roll_button.set_pressed_no_signal(false)

func enable_dim():
    switch_to_dim()
    dim_button.disabled = false
    modulate = ENABLED_COLOR

func disable_dim():
    switch_to_dim()
    dim_button.disabled = true
    modulate = DISABLED_COLOR

# signals callbacks
func _on_RollButton_toggled(_button_pressed):
    emit_signal("dice_gui_roll_button_toggled")

func _on_DimButton_toggled(button_pressed):
    if button_pressed:
        emit_signal("dice_gui_dim_button_pressed", self)
    else:
        emit_signal("dice_gui_dim_button_released")

func _on_InfoButton_pressed():
    emit_signal("dice_gui_info_button_pressed", dice.card)

# private functions
func color_buttons(card):
    roll_button.modulate = ROLLDICT[card.type]
    dim_button.modulate  = ROLLDICT[card.type]

func switch_to_roll():
    roll_button.visible = true
    dim_button.visible = false

func switch_to_dim():
    roll_button.visible = false
    dim_button.visible = true
