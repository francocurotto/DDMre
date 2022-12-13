tool
extends HBoxContainer

# export variables
export (int, 0, 50, 10) var value = 40 setget set_stat_value
export (String, "ATTACK", "DEFENSE", "HEALTH") var stat = "ATTACK" setget set_stat_icon

# constants
const ICONDICT = {"ATTACK"  : "CREST_ATTACK",
                  "DEFENSE" : "CREST_DEFENSE",
                  "HEALTH"  : "HEALTH"}
const COLORDICT = { 0.0 : Color(1.0, 1.0, 1.0),
                    1.0 : Color(0.0, 0.0, 1.0),
                   -1.0 : Color(1.0, 0.0, 0.0)}

# setget functions
func set_stat(_stat, _value):
    set_stat_icon(_stat)
    set_stat_value(_value)

func set_stat_value(_value):
    value = _value
    if has_node("Value"):
        $Value.text = str(value)
    visible = true

func set_stat_value_color(_value, ref):
    set_stat_value(_value)
    $Value.modulate = COLORDICT[sign(_value-ref)]

func set_stat_icon(_stat):
    stat = _stat
    var stat_icon = ICONDICT[stat]
    if has_node("Icon"):
        $Icon.texture = load("res://art/icons/" + stat_icon + ".png")

func hide():
    modulate = Color(1.0, 1.0, 1.0, 0.0)
