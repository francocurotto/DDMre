@tool
extends StaticBody3D

#region constants
const ROTATIONS = {1: Vector3.ZERO, 2: Vector3(0,PI,0)}
#endregion

#region export variables
@export_range(1,2) var player : int = 1 :
	set(_player):
		player = _player
		set_icon()
		var player_material = Globals.PLAYER_MATERIALS[player]
		$MeshInstance3D.set_surface_override_material(0, player_material)
		rotation = ROTATIONS[player]

@export_range(0,3) var hearts : int = 3 :
	set(_hearts):
		hearts = _hearts
		set_icon()
#endregion

#region private functions
func set_icon():
	$Icon.texture = load("res://assets/HEARTS_P%d_%d.svg" % [player, hearts])
#endregion
