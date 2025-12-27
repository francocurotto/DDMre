extends Node3D

#region private variables
var player_guis = {}
#endregion

#region builtin functions
func _enter_tree() -> void:
	Globals.duel = self

func _ready() -> void:
	# setup player guis
	player_guis[1] = $PlayerGUI1
	player_guis[2] = $PlayerGUI2
	$PlayerGUI1.player = 1
	$PlayerGUI2.player = 2
	$PlayerGUI1.endturn_pressed.connect(on_endturn_pressed)
	$PlayerGUI2.endturn_pressed.connect(on_endturn_pressed)
	$PlayerGUI1.monster_attacked.connect(on_monster_attacked)
	$PlayerGUI2.monster_attacked.connect(on_monster_attacked)
	$PlayerGUI1.enable()
	$PlayerGUI2.disable()
	# set initial parameters for player guis and dungeon
	var dungpath =  Init.get("DUNGPATH")
	if not dungpath:
		dungpath = Globals.DUNGPATH
	var dunginit = Globals.read_jsonfile(dungpath)
	$PlayerGUI1.set_initial(Init.get("POOL1PATH"), dunginit.get("CRESTS1"))
	$PlayerGUI2.set_initial(Init.get("POOL2PATH"), dunginit.get("CRESTS2"))
	$Dungeon.set_initial(dunginit)
#endregion

#region signals callbacks
func on_endturn_pressed(player):
	var new_player = switch_player_guis(player)
	player_guis[new_player].state = Globals.GUI_STATE.ROLL

func on_monster_attacked(attacker, attacked):
	var new_player = switch_player_guis(attacker.player)
	player_guis[new_player].state = Globals.GUI_STATE.REPLY
#endregion

#region private functions
func switch_player_guis(current_player):
	var new_player = current_player%2 + 1
	player_guis[current_player].disable()
	player_guis[new_player].enable()
	return new_player
#endregion
