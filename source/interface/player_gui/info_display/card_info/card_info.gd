extends PanelContainer

# onready variables
onready var cardname = $VBox/InfoVBox/Name
onready var tla_info = $VBox/InfoVBox/TLAInfo
onready var attack_info = $VBox/InfoVBox/StatsHBox/AttackInfo
onready var defense_info = $VBox/InfoVBox/StatsHBox/DefenseInfo
onready var health_info = $VBox/InfoVBox/StatsHBox/HealthInfo
onready var abilities_info = $VBox/AbilitiesInfo

# signals
signal card_info_quit

# setget functions
func set_card(card):
    set_name(card.name)
    tla_info.set_tla(card)
    set_card_stats(card)
    if card.TYPE == "MONSTER": # monster info
        set_monster_stats(card)
    abilities_info.set_abilities(card)    

# signals callbacks
func _on_QuitButton_pressed():
    emit_signal("card_info_quit")

# private fuctions
func set_name(name):
    cardname.text = name

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
