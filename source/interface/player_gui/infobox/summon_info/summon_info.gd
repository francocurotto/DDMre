extends "res://interface/player_gui/infobox/info_container.gd"

# onready variables
onready var NameInfo = load("res://interface/player_gui/infobox/dice_info/name_info/name_info.tscn")
onready var SummonStatsInfo = load("res://interface/player_gui/infobox/summon_info/summon_stats_info/summon_stats_info.tscn")

# setget functions
func set_info(kwargs):
    var summon = kwargs["summon"]
    if summon.is_monster():
        set_monster_summon(summon, kwargs.get("target"))
    elif summon.is_item():
        set_item_summon(summon, kwargs.get("player"))

func set_monster_summon(monster, target):
    add_info_node(NameInfo, {"card":monster.card, "hidename":false})
    add_info_node(SummonStatsInfo, {"monster":monster, "target":target})

func set_item_summon(item, player):
    add_info_node(NameInfo, {"card":item.card, "hidename":not item.player==player})
