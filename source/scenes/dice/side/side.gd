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
const HIGHLIGHT_ALPHA = 0.7
#endregion

#region export variables
@export_enum("DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR")
var type : String = "DRAGON" :
	set(_type):
		type = _type
		modulate = Globals.SUMMON_COLORS[type]

@export_enum("SUMMON", "MOVEMENT", "ATTACK", "DEFENSE", "MAGIC", "TRAP")
var crest : String = "SUMMON" :
	set(_crest):
		crest = _crest
		$Crest.texture = load("res://assets/icons/CREST_%s.svg" % crest)
		# reposition mult if summon and not summon
		if crest == "SUMMON":
			%Mult.position = Vector3(0,0,0)
		else:
			%Mult.position = Vector3(0.27,-0.27,0)

@export_range(1,9,1) var mult : int = 1 :
	set(_mult):
		mult = _mult
		%Mult.text = str(mult)

@export_range(1,2,1) var player : int = 1 :
	set(_player):
		player = _player
		$PathTile.player = player

@export var highlight : bool = false :
	set(_highlight):
		highlight = _highlight
		var alpha = 1.0 - int(highlight) + int(highlight)*HIGHLIGHT_ALPHA
		modulate.a = alpha
		$Crest.modulate.a = alpha
		%Mult.modulate.a = alpha
		%Mult.outline_modulate.a = alpha
#endregion

#region onready variables
@onready var pivot_up = $Pivots/PivotUp
@onready var pivot_left = $Pivots/PivotLeft
@onready var pivot_right = $Pivots/PivotRight
@onready var pivot_down = $Pivots/PivotDown

#region public functions
func set_side(_type, level, side_string):
	# set type
	type = _type
	# set summon side
	if side_string == "S":
		crest = "SUMMON"
		mult = level
	# set crest side
	else:
		crest = CRESTDICT[side_string[0]]
		if len(side_string) == 1:
			mult = 1
		else:
			mult = int(side_string[1])

func reparent_summon(summon):
	$PathTile.add_summon(summon)

func reparent_path_tile():
	$PathTile.move_to_dungeon()
#endregion
