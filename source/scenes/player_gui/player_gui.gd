extends VBoxContainer

#region signals
signal endturn_pressed
#endregion

#region constants
const Net = preload("res://scenes/player_gui/net/net.gd")
const LIGHT_POSITION = {1: Vector3(0, 8, 7), 2: Vector3(0, 8, -25)}
const LIGHT_ROTATION = {1: Vector3(-PI/4, 0, 0), 2: Vector3(-3*PI/4, 0, PI)}
const DIMDICE_INIT_POSITION = {1: Vector3(0, 2, -3), 2: Vector3(0, 2, -15)}
const DIMCOOR = {1: Vector2i(6, 3), 2: Vector2i(6, 15)}
#endregion

#region export vatriables
@export_range(1,2,1) var player : int = 1 :
	set(_player):
		player = _player
		$DuelCamera.player = player
		$DirectionalLight3D.position = LIGHT_POSITION[player]
		$DirectionalLight3D.rotation = LIGHT_ROTATION[player]
#endregion

#region public variables
var state : int = Globals.GUI_STATE.ROLL :
	set(_state):
		if state != _state:
			state = _state
			match state :
				Globals.GUI_STATE.DUNGEON: on_switched_to_dungeon_state()
var net = Net.new()
#endregion

#region private variables
var dicelib = Globals.read_jsonfile(Globals.LIBPATH)
#endregion

#region onready variables
@onready var info_gui = $InfoGUI
@onready var dice_gui = $DiceGUI
@onready var dungeon_gui = $DungeonGUI
@onready var duel_camera = $DuelCamera
#endregion

#region builtin functions
func _ready() -> void:
	# setup player_gui reference
	$DungeonGUI.player_gui = self
	$DungeonGUI.duel_camera = duel_camera
	$DiceGUI.dicepool.player_gui = self
	$DiceGUI.rollzone.player_gui = self
	$DiceGUI.net_buttons.player_gui = self
	# setup gui signals connections
	$DiceGUI.dicegui_tab_changed.connect($InfoGUI.on_dicegui_tab_changed)
	$DiceGUI.dicepool.dice_button_focused.connect($InfoGUI.on_dice_button_focused)
	$DiceGUI.rollzone.dimdice_selected.connect($InfoGUI.on_dimdice_selected)
	$DiceGUI.rollzone.dimdice_selected.connect($DungeonGUI.on_dimdice_selected)
	$DuelCamera.camera_moved.connect(func(): dungeon_gui.camera_reset.visible=true)
	# setup dungeon_gui
	dungeon_gui.dimdice_position = DIMDICE_INIT_POSITION[player]
	dungeon_gui.dimcoor = DIMCOOR[player]
	# setup net
	net.type = $DiceGUI.net_buttons.button_group.get_pressed_button().type
	net.rotation = 2*player - 2
	# initialize dicepool
	for i in Globals.DICEPOOL_SIZE:
		var rand_dice = dicelib[str(randi_range(1,len(dicelib)))]
		$DiceGUI.set_dice(i, rand_dice, player)
#endregion

#region public functions
func enable():
	visible = true
	duel_camera.current = true
	$DungeonGUI.enable()

func disable():
	visible = false
	duel_camera.current = false
	$DungeonGUI.disable()

func on_dimension_started():
	$InfoGUI.on_dimension_started()
	$DiceGUI.on_dimension_started()
#endregion

#region signals callbacks
func on_switched_to_dungeon_state():
	$DungeonGUI.on_switched_to_dungeon_state()
#endregion
