@tool
extends StaticBody3D

#region constants
const COLORLIST = {1: Color(0.0,0.0,0.7), 2: Color(0.7,0.0,0.0)}
const ROTATIONS = {1: Vector3.ZERO, 2: Vector3(0,PI,0)}
#endregion

#region export variables
@export_range(1,2) var player : int = 1 :
	set(_player):
		player = _player
		set_icon()
		var material = $MeshInstance3D.get_surface_override_material(0)
		material.albedo_color = COLORLIST[player]
		rotation = ROTATIONS[player]

@export_range(0,3) var hearts : int = 3 :
	set(_hearts):
		hearts = _hearts
		set_icon()

#region private functions
func set_icon():
	$Icon.texture = load("res://assets/HEARTS_P%d_%d.svg" % [player, hearts])
#endregion
