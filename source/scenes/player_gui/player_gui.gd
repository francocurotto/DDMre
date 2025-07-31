extends VBoxContainer

#region constants
const Net = preload("res://scenes/player_gui/net/net.gd")
#endregion

#region export vatriables
@export_range(1,2,1) var player : int = 1
#endregion

#region public variables
var guistate = Globals.GUISTATE.ROLL
var net = Net.new()
#endregion

#region private variables
var dicelib = Globals.read_jsonfile(Globals.LIBPATH)
#endregion

#region onready variables
@onready var info_gui = $InfoGUI
@onready var dice_gui = $DiceGUI
#endregion

#region builtin functions
func _ready() -> void:
	# setup player_gui reference
	$DungeonGUI.player_gui = self
	$DiceGUI.dicepool.player_gui = self
	$DiceGUI.rollzone.player_gui = self
	$DiceGUI.net_buttons.player_gui = self
	# setup gui signals connections
	$DiceGUI.dicegui_tab_changed.connect($InfoGUI.on_dicegui_tab_changed)
	$DiceGUI.dicepool.dice_button_focused.connect($InfoGUI.on_dice_button_focused)
	$DiceGUI.rollzone.dimdice_selected.connect($InfoGUI.on_dimdice_selected)
	$DiceGUI.rollzone.dimdice_selected.connect($DungeonGUI.on_dimdice_selected)
	# setup net
	net.type = $DiceGUI.net_buttons.button_group.get_pressed_button().type
	# initialize dicepool
	for i in Globals.DICEPOOL_SIZE:
		var rand_dice = dicelib[str(randi_range(1,len(dicelib)))]
		rand_dice.player = player
		$DiceGUI.set_dice(i, rand_dice)
#endregion

#region public functions
func on_dimension_started():
	$InfoGUI.on_dimension_started()
	$DiceGUI.on_dimension_started()
#endregion
