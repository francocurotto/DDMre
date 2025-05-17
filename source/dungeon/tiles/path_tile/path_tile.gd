@tool
extends StaticBody3D

#region constants
const COLORLIST = [Color(1,0.6,0.3), Color(0.2,0.3,1), Color(1,0.2,0.3)]
const VORTEX_SPEED = Vector3(0,1,0)
#endregion

#region export variables
@export_range(0,2) var player : int = 1 :
	set(_player):
		player = _player
		$Icon.modulate = COLORLIST[player]
		var material = $MeshInstance3D.get_surface_override_material(0)
		material.albedo_color = COLORLIST[player]

@export var vortex : bool = false :
	set(_vortex):
		vortex = _vortex
		$Vortex.visible = vortex
#endregion

#region builtin functions
func _process(delta: float) -> void:
	if vortex:
		$Vortex.rotation += delta*VORTEX_SPEED
#endregion
