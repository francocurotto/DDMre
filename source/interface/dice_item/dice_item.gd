extends MarginContainer

# variables
var selected = false setget , get_selected
var used = false

# onready variables
onready var index = $HBoxContainer/Index
onready var cardname = $HBoxContainer/Name
onready var type = $HBoxContainer/TLA/Type
onready var level = $HBoxContainer/TLA/Level
onready var ability = $HBoxContainer/TLA/Ability
onready var attack_value = $HBoxContainer/Attack/AttackValue
onready var attack_icon = $HBoxContainer/Attack/AttackIcon
onready var defense_value = $HBoxContainer/Defense/DefenseValue
onready var defense_icon = $HBoxContainer/Defense/DefenseIcon
onready var health_value = $HBoxContainer/Health/HealthValue
onready var health_icon = $HBoxContainer/Health/HealthIcon
onready var sides = $HBoxContainer/Sides
onready var button = $Button

# signals
signal mouse_entered_diceitem(diceitem)
signal mouse_exited_diceitem

# set functions
func set_dice(dice):
    cardname.text =  dice.card.name
    type.texture = load("res://art/icons/TYPE_" + dice.card.type + ".png")
    level.text = str(dice.level)
    # no ability icon
    if dice.card.ability.empty():
        ability.texture = null
    # ability icon
    else:
        ability.texture = load("res://art/icons/ABILITY.png")
    # monster info
    if dice.card.is_monster():
        attack_value.text = str(dice.card.attack)
        defense_value.text = str(dice.card.defense)
        health_value.text = str(dice.card.health)
        attack_icon.texture = load("res://art/icons/CREST_ATTACK.png")
        defense_icon.texture = load("res://art/icons/CREST_DEFENSE.png")
        health_icon.texture = load("res://art/icons/HEALTH.png")
    # item info
    else:
        attack_value.text = ""
        defense_value.text = ""
        health_value.text = ""
        attack_icon.texture = null
        defense_icon.texture = null
        health_icon.texture = null
    for i in dice.sides.size():
        sides.get_child(i).set_side(dice.sides[i])

func set_index(i):
    index.text = str(i+1) + "."

# public functions
func get_selected():
    return $Button.pressed and not $Button.disabled

func enable():
    button.disabled = false

func disable():
    button.disabled = true

func release():
    button.pressed = false

func disable_unselected():
    if not self.selected:
        button.disabled = true

func enable_unused():
    if not used:
        button.disabled = false

# signals callbacks
func _on_Button_mouse_entered():
    emit_signal("mouse_entered_diceitem", self)

func _on_Button_mouse_exited():
    emit_signal("mouse_exited_diceitem")
