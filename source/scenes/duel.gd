extends Node3D

#region private variables
var player_guis = {}
#endregion

#region builtin functions
func _enter_tree() -> void:
	Globals.duel = self

func _ready() -> void:
	player_guis[1] = $PlayerGUI1
	player_guis[2] = $PlayerGUI2
	$PlayerGUI1.player = 1
	$PlayerGUI2.player = 2
	$PlayerGUI1.endturn_pressed.connect(on_endturn_pressed)
	$PlayerGUI2.endturn_pressed.connect(on_endturn_pressed)
	$PlayerGUI1.enable()
	$PlayerGUI2.disable()
#endregion

#region signals callbacks
func on_endturn_pressed(player):
	var new_player = player%2 + 1
	player_guis[player].disable()
	player_guis[new_player].enable()
	player_guis[new_player].state = Globals.GUI_STATE.ROLL
#endregion
