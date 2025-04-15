extends Node3D

#region variables
var dicelib ## dice database read from the json file.
var rng     ## RNG object.
#endregion

#region builtin functions
func _init() -> void:
	# initialize RNG
	rng = RandomNumberGenerator.new()
	rng.randomize()
	
	# load dice library
	dicelib = Globals.read_jsonfile(Globals.LIBPATH)

func _ready() -> void:
	pass
#endregion
