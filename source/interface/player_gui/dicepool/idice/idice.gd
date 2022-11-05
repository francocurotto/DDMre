extends MarginContainer

# constants
const ROLLDICT = {"DRAGON"      : Color(1.5, 0.0, 0.0, 1.0), 
                  "SPELLCASTER" : Color(1.5, 1.5, 1.5, 1.0),
                  "UNDEAD"      : Color(1.5, 1.5, 0.0, 1.0),
                  "BEAST"       : Color(0.0, 1.5, 0.0, 1.0),
                  "WARRIOR"     : Color(0.0, 0.0, 1.5, 1.0),
                  "ITEM"        : Color(0.5, 0.5, 0.5, 1.0)}
const ENABLE_COLOR = Color(1.0, 1.0, 1.0, 1.0)
const DISABLE_COLOR = Color(0.3, 0.3, 0.3, 1.0)

# variables
var idx
var roll_selected setget , get_roll_selected
var dim_selected setget , get_dim_selected

# onready variables
onready var index_value = $HBoxContainer/Index
onready var cardname = $HBoxContainer/Name
onready var tla = $HBoxContainer/TLA
onready var attack = $HBoxContainer/Attack
onready var defense = $HBoxContainer/Defense
onready var health = $HBoxContainer/Health
onready var isides = $HBoxContainer/ISides
onready var roll_button = $RollButton
onready var dim_button = $DimButton

# signals
signal mouse_entered_diceitem(diceitem)
signal mouse_exited_diceitem
signal dim_button_pressed(idx)
signal dim_button_released

# setget functions
func set_dice(dice):
    cardname.text =  dice.card.name
    tla.set_tla(dice.card)
    set_card_stats(dice.card)
    isides.set_sides(dice.sides)
    color_buttons(dice.card)

func set_index(_idx):
    idx = _idx
    index_value.text = str(idx+1) + "."

func get_roll_selected():
    return roll_button.pressed

func get_dim_selected():
    return dim_button.pressed

func enable_roll():
    roll_button.disabled = false
    color_enable()

func disable_roll():
    roll_button.disabled = true
    color_disable()

func release_roll():
    roll_button.pressed = false

func disable_roll_unselected():
    if not self.roll_selected:
        disable_roll()

func enable_dim():
    dim_button.disabled = false
    #color_enable()

func disable_dim():
    dim_button.disabled = true
    #color_disable()

func switch_to_dim_button():
    roll_button.visible = false
    dim_button.visible = true
    color_enable()

func switch_to_roll_button():
    roll_button.visible = true
    dim_button.visible = false

func color_disable():
    modulate = DISABLE_COLOR

func color_enable():
    modulate = ENABLE_COLOR

# signals callbacks
func _on_RollButton_mouse_entered():
    emit_signal("mouse_entered_diceitem", self)

func _on_RollButton_mouse_exited():
    emit_signal("mouse_exited_diceitem")

func _on_DimButton_mouse_entered():
    _on_RollButton_mouse_entered()

func _on_DimButton_mouse_exited():
    _on_RollButton_mouse_exited()

func _on_DimButton_toggled(pressed):
    if pressed:
        emit_signal("dim_button_pressed", idx)
    else:
        emit_signal("dim_button_released")

# private functions
func set_card_stats(card):
    if card.is_monster(): # monster info
        set_monster_stats(card)
    else: # item info
        set_item_stats()

func set_monster_stats(card):
    attack.set_dice_stat("ATTACK", card.attack)
    defense.set_dice_stat("DEFENSE", card.defense)
    health.set_dice_stat("HEALTH", card.health)

func set_item_stats():
    attack.disable()
    defense.disable()
    health.disable()

func color_buttons(card):
    roll_button.modulate = ROLLDICT[card.type]
    dim_button.modulate = ROLLDICT[card.type]
