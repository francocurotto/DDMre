extends HBoxContainer

# onready variables
onready var cardname = $VBox/Name
onready var tla_info = $VBox/HBox/TLAInfo
onready var attack_info = $VBox/HBox/AttackInfo
onready var defense_info = $VBox/HBox/DefenseInfo
onready var health_info = $VBox/HBox/HealthInfo
onready var sides_info = $SidesInfo

# setget functions
func set_dice(dice):
    cardname.text = dice.card.name
    tla_info.set_tla(dice.card)
    set_card_stats(dice.card)
    sides_info.set_sides(dice.sides)

# private functions
func set_card_stats(card):
    if card.TYPE == "MONSTER": # monster info
        set_monster_stats(card)
    else: # item info
        set_item_stats()

func set_monster_stats(card):
    attack_info.set_stat("ATTACK", card.attack)
    defense_info.set_stat("DEFENSE", card.defense)
    health_info.set_stat("HEALTH", card.health)

func set_item_stats():
    attack_info.hide()
    defense_info.hide()
    health_info.hide()
