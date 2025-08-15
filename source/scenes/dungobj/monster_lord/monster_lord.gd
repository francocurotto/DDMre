@tool
extends Node3D

#region export variables
@export_range(1,2) var player : int = 1 :
	set(_player):
		player = _player
		set_icon()
		var player_material = Globals.PLAYER_MATERIALS[player]
		$HEART.set_surface_override_material(0, player_material)

@export_range(0,3) var hearts : int = 3 :
	set(_hearts):
		hearts = _hearts
		set_icon()
#endregion

#region private functions
func set_icon():
	$Icon1.texture = load("res://assets/icons/HEARTS_P%d_%d.svg" % [player, hearts])
	$Icon2.texture = load("res://assets/icons/HEARTS_P%d_%d.svg" % [player, hearts])
#endregion
