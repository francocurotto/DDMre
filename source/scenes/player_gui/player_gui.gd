extends VBoxContainer

#region public variables
var state = State.new()
#endregion

#region private variables
var dicelib = Globals.read_jsonfile(Globals.LIBPATH)
#endregion

#region builtin functions
func _ready() -> void:
	# setup state
	$DungeonGUI.state = state
	$DiceGUI.state = state
	# initialize dicepool
	for i in Globals.DICEPOOL_SIZE:
		# get a random dice
		var rand_dice = dicelib[str(randi_range(1,len(dicelib)))]
		# set dicepool dice
		$DiceGUI.set_dice(i, rand_dice)
#endregion

#region subclasses
class State:
	var value : int = Globals.GUISTATE.ROLL
#endregion
