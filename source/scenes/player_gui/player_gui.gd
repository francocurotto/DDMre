extends VBoxContainer

#region constants
const Net = preload("res://scenes/player_gui/net.gd")
#endregion

#region public variables
var state = Globals.GUISTATE.ROLL
var net = Net.new()
#endregion

#region private variables
var dicelib = Globals.read_jsonfile(Globals.LIBPATH)
#endregion

#region builtin functions
func _ready() -> void:
	# setup playergui reference
	$DungeonGUI.playergui = self
	$DiceGUI.rollzone.playergui = self
	$DiceGUI.net_buttons.playergui = self
	# setup net
	net.type = $DiceGUI.net_buttons.button_group.get_pressed_button().type
	# initialize dicepool
	for i in Globals.DICEPOOL_SIZE:
		# get a random dice
		var rand_dice = dicelib[str(randi_range(1,len(dicelib)))]
		# set dicepool dice
		$DiceGUI.set_dice(i, rand_dice)
#endregion
