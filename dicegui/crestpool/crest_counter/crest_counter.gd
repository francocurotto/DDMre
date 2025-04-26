@tool
extends HBoxContainer

@export_enum("MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP")
var type : String = "MOVEMENT" :
	set(_type):
		type = _type
		$TextureRect.texture = load("res://assets/CREST_%s.svg" % type)
