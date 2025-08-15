@tool
extends Button

#region export variables
@export_enum("T", "Y", "Z", "V", "X", "N", "M", "E", "P", "R", "L")
var type : String = "X" :
	set(_type):
		type = _type
		icon = load("res://assets/icons/NET_%s.png" % type)
#endregion
