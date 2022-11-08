tool
extends HBoxContainer

# export variables
export (int, 0, 50, 10) var value = 40 setget set_stat_value
export (String, "ATTACK", "DEFENSE", "HEALTH") var stat = "ATTACK" setget set_stat_icon

# constants
const ICONDICT = {"ATTACK"  : "CREST_ATTACK",
                  "DEFENSE" : "CREST_DEFENSE",
                  "HEALTH"  : "HEALTH"}

# setget functions
func set_dice_stat(_stat, _value):
    set_stat_icon(_stat)
    set_stat_value(_value)

func set_stat_value(_value):
    value = _value
    if has_node("Value"):
        $Value.text = str(value)

func set_stat_icon(_stat):
    stat = _stat
    var stat_icon = ICONDICT[stat]
    if has_node("Icon"):
        $Icon.texture = load("res://art/icons/" + stat_icon + ".png")

func hide():
    modulate = Color(1.0, 1.0, 1.0, 0.0)

func modulate_value(color):
    $Label.modulate = color
