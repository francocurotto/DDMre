extends PanelContainer

# onready variables
onready var cardname = $VBox/InfoVBox/Name
onready var tla = $VBox/InfoVBox/TLA
onready var attack = $VBox/InfoVBox/StatsHBox/Attack
onready var defense = $VBox/InfoVBox/StatsHBox/Defense
onready var health = $VBox/InfoVBox/StatsHBox/Health

# signals
signal cardinfo_quit

# setget functions
func set_card(card):
    set_name(card.name)
    tla.set_tla(card)
    set_card_stats(card)
    if card.is_monster(): # monster info
        set_monster_stats(card)

# signals callbacks
func _on_QuitButton_pressed():
    emit_signal("cardinfo_quit")

# private fuctions
func set_name(name):
    cardname.text = name

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
