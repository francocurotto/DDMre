@tool
extends HBoxContainer

#region export variables
@export_enum("LEVEL", "ATTACK", "DEFENSE")
var attr : String = "LEVEL" :
	set(_attr):
		attr = _attr
		$Attr.texture = load("res://assets/ATTR_%s.svg" % attr)

@export var value : int = 1 :
	set(_value):
		value = _value
		$Value.text = str(value)
		set_value_color()

@export var original_value : int = 1 :
	set(_original_value):
		original_value = _original_value
		value = original_value
		set_value_color()
#endregion

#region private functions
func set_value_color():
	if value == original_value:
		$Value.modulate = Color(1,1,1)
	elif value < original_value:
		$Value.modulate = Color(1,0,0)
	else: # value > original value
		$Value.modulate = Color(0,0,1)
#endregion
