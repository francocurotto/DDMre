extends VBoxContainer

# onready variables
onready var cardname = $Name
onready var tla = $DiceLine/TLA
onready var attack = $DiceLine/Attack
onready var defense = $DiceLine/Defense
onready var health = $DiceLine/Health
onready var sides = $DiceLine/Sides

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
