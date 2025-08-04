@tool
extends Node3D

#region export variables
@export_enum("ATTACK", "DEFENSE")
var attr : String = "ATTACK" :
	set(_attr):
		attr = _attr
		$AttrIcon.texture = load("res://assets/ATTR_%s.svg" % attr)

@export_range(0, 90, 10) var value : int = 10 :
	set(_value):
		value = _value
		$AttrValue.text = str(value)
		set_value_color()

@export_range(0, 50, 10) var original_value : int = 10 :
	set(_original_value):
		original_value = _original_value
		value = original_value
		$AttrValue.text = str(value)
		set_value_color()
#endregion

#region private functions
func set_value_color():
	if value == original_value:
		$AttrValue.modulate = Color(1,1,1)
	elif value < original_value:
		$AttrValue.modulate = Color(1,0,0)
	else: # value > original value
		$AttrValue.modulate = Color(0,0,1)
#endregion
