extends HBoxContainer

# onready variables
onready var tla = $TLA
onready var summon_name = $Name
onready var attack = $MonsterStats/Attack
onready var defense = $MonsterStats/Defense
onready var health = $MonsterStats/Health

# setget functions
func set_summon(summon, player):
    tla.set_tla(summon.card)
    set_summon_name(summon, player)
    set_summon_stats(summon)
    visible = true

func clear():
    visible = false

# private functions
func set_summon_name(summon, player):
    if summon.is_item() and player != summon.player:
        summon_name.text = "???"
    else:
        summon_name.text = summon.card.name

func set_summon_stats(summon):
    if summon.card.is_monster(): # monster info
        set_monster_stats(summon)
    else: # item info
        set_item_stats()

func set_monster_stats(summon):
    attack.set_stat_value_color(summon.attack, summon.card.attack)
    defense.set_stat_value_color(summon.defense, summon.card.defense)
    health.set_stat_value_color(summon.health, summon.card.health)

func set_item_stats():
    attack.visible = false
    defense.visible = false
    health.visible = false

