tool
extends VBoxContainer

# onready variables
onready var NameInfo = load("res://interface/player_gui/infobox/dice_info/name_info/name_info.tscn")
onready var MonsterCardInfo = load("res://interface/player_gui/infobox/dice_info/monster_card_info/monster_card_info.tscn")
onready var SidesInfo = load("res://interface/player_gui/infobox/dice_info/sides_info/sides_info.tscn")

# set functions 
func set_info(kwargs):
    var dice = kwargs["dice"]
    if dice.card.is_monster():
        set_monster_card(dice.card)
    elif dice.card.is_item():
        set_item_card(dice.card)
    InfoGlobals.add_info_node(self, SidesInfo, {"sides":dice.sides})

func set_monster_card(card):
    InfoGlobals.add_info_node(self, NameInfo, {"card":card, "hidename":false})
    InfoGlobals.add_info_node(self, MonsterCardInfo, {"card":card})

func set_item_card(card):
    InfoGlobals.add_info_node(self, NameInfo, {"card":card, "hidename":false})
