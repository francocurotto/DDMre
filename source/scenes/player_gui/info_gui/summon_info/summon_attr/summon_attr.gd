@tool
extends HBoxContainer

#region export variables
@export_enum("LEVEL", "ATTACK", "DEFENSE", "HEALTH")
var attr : String = "LEVEL" :
	set(_attr):
		attr = _attr
		$Attr.texture = load("res://assets/ATTR_%s.svg" % attr)

@export var value : int = 1 :
	set(_value):
		value = _value
		$Value.text = str(value)
#endregion
