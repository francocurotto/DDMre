@tool
extends MarginContainer

#region constants
const MAXAMOUNT = 99
#endregion

#region public variables
var amount : int = 0 :
	set(_amount):
		amount = clamp(_amount, 0, MAXAMOUNT)
		var string = str(amount)
		if len(string) < 2:
			string = "0" + string
		animate_update(string)
#endregion

#region export variables
@export_enum("MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP")
var type : String = "MOVEMENT" :
	set(_type):
		type = _type
		%TextureRect.texture = load("res://assets/CREST_%s.svg" % type)
#endregion

#region public functions
func add_crest(increment):
	amount = amount + increment
#endregion

#region private functions
func animate_update(string):
	var tween = create_tween()
	# in tween
	tween.tween_property($ColorRect, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.5)
	await tween.finished
	# update label
	%Label.text = string
	# out tween
	tween.tween_property($ColorRect, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.5)
#endregion
