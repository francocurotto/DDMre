extends MarginContainer

# variables
var selected = false setget , get_selected
var used = false

# onready variables
onready var index_value = $HBoxContainer/Index
onready var cardname = $HBoxContainer/Name
onready var type = $HBoxContainer/TLA/Type
onready var level = $HBoxContainer/TLA/Level
onready var ability_icon = $HBoxContainer/TLA/Ability
onready var attack_value = $HBoxContainer/Attack/AttackValue
onready var attack_icon = $HBoxContainer/Attack/AttackIcon
onready var defense_value = $HBoxContainer/Defense/DefenseValue
onready var defense_icon = $HBoxContainer/Defense/DefenseIcon
onready var health_value = $HBoxContainer/Health/HealthValue
onready var health_icon = $HBoxContainer/Health/HealthIcon
onready var isides = $HBoxContainer/ISides
onready var button = $Button

# signals
signal mouse_entered_diceitem(diceitem)
signal mouse_exited_diceitem

# setget functions
func set_dice(dice):
    cardname.text =  dice.card.name
    type.texture = load("res://art/icons/TYPE_" + dice.card.type + ".png")
    level.text = str(dice.level)
    set_dice_ability(dice.card.ability)
    set_card_stats(dice.card)
    set_sides(dice.sides)

func set_index(idx):
    index_value.text = str(idx+1) + "."

func get_selected():
    return button.pressed and not button.disabled

# public functions
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

# private functions
func set_dice_ability(ability):
    if ability.empty():  # no ability icon
        ability_icon.texture = null
    else: # ability icon
        ability_icon.texture = load("res://art/icons/ABILITY.png")

func set_card_stats(card):
    if card.is_monster(): # monster info
        set_monster_stats(card)
    else: # item info
        set_item_stats()

func set_monster_stats(card):
    attack_value.text = str(card.attack)
    defense_value.text = str(card.defense)
    health_value.text = str(card.health)
    attack_icon.texture = load("res://art/icons/CREST_ATTACK.png")
    defense_icon.texture = load("res://art/icons/CREST_DEFENSE.png")
    health_icon.texture = load("res://art/icons/HEALTH.png")

func set_item_stats():
    attack_value.text = ""
    defense_value.text = ""
    health_value.text = ""
    attack_icon.texture = null
    defense_icon.texture = null
    health_icon.texture = null    

func set_sides(sides):
    for i in sides.size():
        isides.get_child(i).set_side(sides[i])
