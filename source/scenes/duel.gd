extends Node3D

#region builtin functions
func _ready() -> void:
	$PlayerGUI.endturn_pressed.connect(on_endturn_pressed)
	#$PlayerGUI1.endturn_pressed.connect(on_endturn_pressed)
	#$PlayerGUI2.endturn_pressed.connect(on_endturn_pressed)
#endregion

#region signals callbacks
func on_endturn_pressed(player):
	var new_player = player%2 + 1
	print("player: " + str(player))
	print("new player: " + str(new_player))
	#PLAYER_GUIS[player].disable()
	#PLAYER_GUIS[player].enable()
#endregion
