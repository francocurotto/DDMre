extends VBoxContainer

# onready variables
onready var NameInfo = load("res://interface/player_gui/infobox/dice_info/name_info/name_info.tscn")
onready var MonsterSummonInfo = load("res://interface/player_gui/infobox/summon_info/monster_summon_info/monster_summon_info.tscn")

# setget functions
func set_info(kwargs):
    var summon = kwargs["summon"]
    if summon.is_monster():
        set_monster_summon(summon, kwargs.get("target"))
    elif summon.is_item():
        set_item_summon(summon, kwargs.get("player"))

func set_monster_summon(monster, target):
    InfoGlobals.add_info_node(self, NameInfo, {"card":monster.card, "hidename":false})
    InfoGlobals.add_info_node(self, MonsterSummonInfo, {"monster":monster, "target":target})

func set_item_summon(item, player):
    InfoGlobals.add_info_node(self, NameInfo, {"card":item.card, "hidename":not item.player==player})
