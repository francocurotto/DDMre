@tool
extends HBoxContainer

# export variables
@export_range(0, 60, 10) var value = 10 :
    set(_value):
        value = _value
        set_value()

@export_range(0, 60, 10) var original_value = 10 :
    set(_original_value):
        original_value = _original_value
        set_value()

@export_enum("ATTACK", "DEFENSE", "HEALTH") 
var attr_type : String = "ATTACK" :
    set(_attr_type):
        attr_type = _attr_type
        $Icon.texture = load("res://assets/icons/ATTR_%s.svg" % attr_type)

func set_value():
    $Value.text = str(value)
    $Value.modulate = COLORDICT[sign(value-original_value)]

# constants
const COLORDICT = { 0 : Color(1.0, 1.0, 1.0),
                    1 : Color(0.0, 0.0, 1.0),
                   -1 : Color(1.0, 0.0, 0.0)}
