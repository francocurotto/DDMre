extends HBoxContainer

# onready variables
onready var cardname = $VBox/Name
onready var tla = $VBox/HBox/TLA
onready var attack = $VBox/HBox/Attack
onready var defense = $VBox/HBox/Defense
onready var health = $VBox/HBox/Health
onready var sides = $Sides

# setget functions
func set_dice(dice):
    cardname.text = dice.card.name
    tla.set_tla(dice.card)
    set_card_stats(dice.card)
    sides.set_sides(dice.sides)

# private functions
func set_card_stats(card):
    if card.is_monster(): # monster info
        set_monster_stats(card)
    else: # item info
        set_item_stats()

func set_monster_stats(card):
    attack.set_stat("ATTACK", card.attack)
    defense.set_stat("DEFENSE", card.defense)
    health.set_stat("HEALTH", card.health)

func set_item_stats():
    attack.hide()
    defense.hide()
    health.hide()
