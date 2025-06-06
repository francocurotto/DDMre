extends VBoxContainer

#region private variables
var dicelib
#endregion

#region builtin functions
func _init() -> void:
	# load dice library
	dicelib = Globals.read_jsonfile(Globals.LIBPATH)

func _ready() -> void:
	# initialize dicepool
	for i in Globals.DICEPOOL_SIZE:
		# get a random dice
		var rand_dice = dicelib[str(randi_range(1,len(dicelib)))]
		# set dicepool dice
		$DiceGUI.set_dice(i, rand_dice)
#endregion
