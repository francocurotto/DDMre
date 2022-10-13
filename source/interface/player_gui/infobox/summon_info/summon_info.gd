tool
extends VBoxContainer

# variables
var player
var name_info
var monster_summon_info
var monster_card_info
var sides_info

# onready variables
onready var NameInfo = load("res://interface/player_gui/infobox/name_info/name_info.tscn")
onready var MonsterSummonInfo = load("res://interface/player_gui/infobox/monster_summon_info/monster_summon_info.tscn")
onready var MonsterCardInfo = load("res://interface/player_gui/infobox/monster_card_info/monster_card_info.tscn")
onready var SidesInfo = load("res://interface/player_gui/infobox/sides_info/sides_info.tscn")

func _ready():
    name_info = NameInfo.instance()
    monster_summon_info = MonsterSummonInfo.instance()
    monster_card_info = MonsterCardInfo.instance()
    sides_info = SidesInfo.instance()

# set functions 
func set_player(_player):
    player = _player

func set_dice(idx):
    clear_summon_info()
    var dice = player.dicepool[idx]
    if dice.card.is_monster():
        set_monster_card(dice.card)
    elif dice.card.is_item():
        set_item_card(dice.card)
    add_sides_info(dice.sides)

func set_summon(summon):
    #clear_summon_info()
    if summon.is_monster():
        set_monster_summon(summon)
    elif summon.is_item():
        set_item_summon(summon)

func set_monster_card(card):
    add_name_info(card)
    add_monster_card_info(card)

func set_item_card(card):
    add_name_info(card)

func set_monster_summon(monster):
    add_name_info(monster.card)
    add_monster_summon_info(monster)

func set_item_summon(item):
    add_name_info(item.card, not player.items.has(item))

# private functions
func clear_summon_info():
    for child in get_children():
        child.queue_free()

func add_name_info(card, hide_name=false):
    add_child(name_info)
    name_info.set_name_info(card, hide_name)

func add_monster_card_info(card):
    add_child(monster_card_info)
    monster_card_info.set_monster_card_info(card)

func add_monster_summon_info(monster):
    add_child(monster_summon_info)
    monster_summon_info.set_monster_summon_info(monster)

func add_sides_info(sides):
    add_child(sides_info)
    sides_info.set_sides_info(sides)
