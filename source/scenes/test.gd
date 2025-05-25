extends Node3D

#region variables
var dicelib ## dice database read from the json file.
var rng     ## RNG object.
#endregion

#region constants
const DUNGEON_HEIGHT = 19 ## Number of verical tiles of dungeon. 
const DUNGEON_WIDTH  = 13 ## Number of horizontal tiles of dungeon.
const DICEPOOL_SIZE  = 15 ## Number of dice in player dicepool.
const MAX_CRESTS     = 99 ## Maximum number of crests for each crest type
const MAX_HEARTS     = 3  ## Maximum number of hearts per player
#endregion

#region builtin functions
func _init() -> void:
	# initialize RNG
	rng = RandomNumberGenerator.new()
	rng.randomize()
	# load dice library
	dicelib = Globals.read_jsonfile(Globals.LIBPATH)

func _ready() -> void:
	# initialize dicepool
	for i in DICEPOOL_SIZE:
		# get a random dice
		var rand_dice = dicelib[str(rng.randi_range(1,len(dicelib)))]
		# set dicepool dice
		%DiceGUI.set_dice(i, rand_dice)

func _input(event):
	if event is InputEventScreenDrag:
		# Check if the touch is inside the drag area
		if %CameraGUI.get_global_rect().has_point(event.position):
			var movement = Vector3(event.velocity.x, 0, event.velocity.y)
			$Camera3D.position -= 0.0004 * movement
#endregion
