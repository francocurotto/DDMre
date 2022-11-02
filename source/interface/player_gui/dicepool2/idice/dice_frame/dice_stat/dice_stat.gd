tool
extends HBoxContainer

# export variables
export (String, "SUMMON", "ATTACK", "DEFENSE", "HEALTH") var stat = "SUMMON" setget set_stat_icon
export (int) var value = 3 setget set_stat_value

# constants
const ICONDICT = {"SUMMON"  : "CREST_SUMMON",
                  "ATTACK"  : "CREST_ATTACK",
                  "DEFENSE" : "CREST_DEFENSE",
                  "HEALTH"  : "HEALTH"}

# setget functions
func set_dice_stat(_stat, _value):
    set_stat_icon(_stat)
    set_stat_value(_value)

func set_stat_icon(_stat):
    stat = _stat
    var stat_icon = ICONDICT[stat]
    $Icon.texture = load("res://art/icons/" + stat_icon + ".png")

func set_stat_value(_value):
    value = _value
    $Label.text = str(value)
