extends "res://interface/player_gui/infobox/info_container.gd"

# preload variables
var NameInfo = preload("res://interface/player_gui/infobox/dice_info/name_info/name_info.tscn")
var CardStatsInfo = preload("res://interface/player_gui/infobox/dice_info/card_stats_info/card_stats_info.tscn")
var ISides = preload("res://interface/player_gui/dicepool/idice/isides/isides.tscn")

# setget functions
func set_info(kwargs):
    var dice = kwargs["dice"]
    if dice.card.is_monster():
        set_monster_card(dice.card)
    elif dice.card.is_item():
        set_item_card(dice.card)
    add_info_node(ISides, {"sides":dice.sides})

func set_monster_card(card):
    add_info_node(NameInfo, {"card":card, "hidename":false})
    add_info_node(CardStatsInfo, {"card":card})

func set_item_card(card):
    add_info_node(NameInfo, {"card":card, "hidename":false})
