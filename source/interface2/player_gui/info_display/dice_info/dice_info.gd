tool
extends VBoxContainer

# preload variables
var font = preload("res://art/fonts/dice_info_name.tres")

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

# signals callbacks
func _on_VBoxContainer_resized():
    var fontsize = get_size().y - $DiceLine/TLA/Level.get_size().y - 7
    if fontsize >= 12:
        font.size = min(24, fontsize)
        $Name.visible = true
    else:
        $Name.visible = false

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
