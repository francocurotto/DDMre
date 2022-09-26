extends VBoxContainer

# export variables
export(PackedScene) var SideItem

# variables
var player

# onready variables
onready var cardname = $TLAName/Name
onready var type = $TLAName/TLA/Type
onready var level = $TLAName/TLA/Level
onready var ability_icon = $TLAName/TLA/Ability
onready var attack_value = $ADH/Attack/AttackValue
onready var attack_icon = $ADH/Attack/AttackIcon
onready var defense_value = $ADH/Defense/DefenseValue
onready var defense_icon = $ADH/Defense/DefenseIcon
onready var health_value = $ADH/Health/HealthValue
onready var health_icon = $ADH/Health/HealthIcon
onready var isides = $ISides

# set functions 
func set_player(_player):
    player = _player

func set_dice(idx):
    var dice = player.dicepool[idx]
    cardname.text = dice.card.name
    type.texture = load("res://art/icons/TYPE_" + dice.card.type + ".png")
    level.text = str(dice.level)
    set_ability(dice.card.ability)
    set_card_stats(dice.card)
    set_sides(dice.sides)

func set_ability(ability):
    if ability.empty():  # no ability icon
        ability_icon.texture = null
    else: # ability icon
        ability_icon.texture = load("res://art/icons/ABILITY.png")

func set_card_stats(card):
    if card.is_monster(): # monster info
        set_monster_stats(card)
        $ADH.visible = true
    else: # item info
        $ADH.visible = false
        
func set_monster_stats(card):
    attack_value.text = str(card.attack)
    defense_value.text = str(card.defense)
    health_value.text = str(card.health)

func set_sides(sides):
    for i in sides.size():
        isides.get_child(i).set_side(sides[i])
