@tool
extends StaticBody3D

#region constants
const COLORLIST = [Color(1,0.6,0.3), Color(0.2,0.3,1), Color(1,0.2,0.3)]
const VORTEX_SPEED = Vector3(0,1,0)
const MonsterLord = preload("res://dungobj/monster_lord/monster_lord.tscn")
#endregion

#region export variables
@export_range(0,2) var player : int = 1 :
	set(_player):
		player = _player
		set_player()

@export var monster_lord : bool = false :
	set(_monster_lord):
		monster_lord = _monster_lord
		set_player()

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

#region private functions
func set_player():
	# set player color
	$Icon.modulate = COLORLIST[player]
	var material = $MeshInstance3D.get_surface_override_material(0)
	material.albedo_color = COLORLIST[player]
	# set mpnster lord
	if $Dungobj.get_child_count() >= 1:
		$Dungobj.get_child(0).queue_free()
	if monster_lord and player != 0:
		var monster_lord_obj = MonsterLord.instantiate()
		monster_lord_obj.player = player
		$Dungobj.add_child(monster_lord_obj)
#endregion
