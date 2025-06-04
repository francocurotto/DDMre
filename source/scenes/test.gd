extends Node3D

#region variables
var dicelib ## dice database read from the json file.
var rng     ## RNG object.
var dragging = false
#endregion

#region constants

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
	for i in Globals.DICEPOOL_SIZE:
		# get a random dice
		var rand_dice = dicelib[str(rng.randi_range(1,len(dicelib)))]
		# set dicepool dice
		%DiceGUI.set_dice(i, rand_dice)

func _input(event):
	if event is InputEventScreenDrag:
		dragging = true
		# Check if the touch is inside the drag area
		if %DungeonGUI.get_global_rect().has_point(event.position):
			var movement = Vector3(event.velocity.x, 0, event.velocity.y)
			$Camera3D.position -= 0.0004 * movement
	elif event is InputEventScreenTouch and not event.pressed:
		if not dragging: # check if it was not dragging input
			$Dungeon.dungeon_touch(event)
		dragging = false 
#endregion
