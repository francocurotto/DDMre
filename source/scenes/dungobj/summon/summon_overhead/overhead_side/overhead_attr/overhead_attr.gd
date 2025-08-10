@tool
extends Node3D

#region export variables
@export_enum("ATTACK", "DEFENSE")
var attr : String = "ATTACK" :
	set(_attr):
		attr = _attr
		$AttrIcon.texture = load("res://assets/ATTR_%s.svg" % attr)

@export var alpha : float = 1.0 :
	set(_alpha):
		alpha = _alpha
		$AttrIcon.modulate.a = alpha
		$AttrValue.modulate.a = alpha
		$AttrValue.outline_modulate.a = alpha
#endregion

#region public functions
func set_value(original_value, value):
	$AttrValue.text = str(value)
	if value == original_value:
		$AttrValue.modulate = Color(1,1,1)
	elif value < original_value:
		$AttrValue.modulate = Color(1,0,0)
	else: # value > original value
		$AttrValue.modulate = Color(0,0,1)
#endregion
