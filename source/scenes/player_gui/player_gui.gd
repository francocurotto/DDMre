extends VBoxContainer

#region public variables
var guistate = GuiState.new()
#endregion

#region private variables
var dicelib = Globals.read_jsonfile(Globals.LIBPATH)
#endregion

#region builtin functions
func _ready() -> void:
	# setup state
	$DungeonGUI.guistate = guistate
	$DiceGUI.guistate = guistate
	# initialize dicepool
	for i in Globals.DICEPOOL_SIZE:
		# get a random dice
		var rand_dice = dicelib[str(randi_range(1,len(dicelib)))]
		# set dicepool dice
		$DiceGUI.set_dice(i, rand_dice)
#endregion

#region subclasses
class GuiState:
	var value : int = Globals.GUISTATE.ROLL
#endregion
