@tool
extends Sprite3D

#region constants
const CRESTDICT = {
	"M" : "MOVEMENT",
	"A" : "ATTACK",
	"D" : "DEFENSE",
	"G" : "MAGIC",
	"T" : "TRAP"
}
#endregion

#region export variables
@export_enum("SUMMON", "MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP")
var type : String = "SUMMON" :
	set(_type):
		type = _type
		texture = load("res://assets/CREST_%s.svg" % type)
		# reposition mult if summon and not summon
		if type == "SUMMON":
			$Mult.position = Vector3(0,0,0)
		else:
			$Mult.position = Vector3(0.27,-0.27,0)

@export_range(1,9) var mult : int = 1 :
	set(_mult):
		mult = _mult
		$Mult.text = str(mult)
#endregion

#region public functions
func set_side(level, side_string):
	# set summon side
	if side_string == "S":
		type = "SUMMON"
		mult = level
	# set crest side
	else:
		type = CRESTDICT[side_string[0]]
		if len(side_string) == 1:
			mult = 1
		else:
			mult = int(side_string[1])
#endregion
