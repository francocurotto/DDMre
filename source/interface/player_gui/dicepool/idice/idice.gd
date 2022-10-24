extends MarginContainer

# variables
var idx
var roll_selected setget , get_roll_selected
var dim_selected setget , get_dim_selected

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
    type.texture = load("res://art/icons/TYPE_" + dice.card.type + ".png")
    level.text = str(dice.level)
    set_dice_ability(dice.card.ability)
    set_card_stats(dice.card)
    set_sides(dice.sides)

func set_index(_idx):
    idx = _idx
    index_value.text = str(idx+1) + "."

func get_roll_selected():
    return roll_button.pressed

func get_dim_selected():
    return dim_button.pressed

func enable_roll():
    roll_button.disabled = false

func disable_roll():
    roll_button.disabled = true

func release_roll():
    roll_button.pressed = false

func disable_roll_unselected():
    if not self.roll_selected:
        roll_button.disabled = true

func enable_dim():
    dim_button.disabled = false

func disable_dim():
    dim_button.disabled = true

func switch_to_dim_button():
    roll_button.visible = false
    dim_button.visible = true

func switch_to_roll_button():
    roll_button.visible = true
    dim_button.visible = false

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
