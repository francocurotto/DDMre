@tool
extends StaticBody3D

#region constants
const COLORLIST = [Color(1,0.6,0.3), Color(0.2,0.3,1), Color(1,0.2,0.3)]
const MonsterLord = preload("res://scenes/dungobj/monster_lord/monster_lord.tscn")
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

@export var highlight : bool = false :
	set(_highlight):
		highlight = _highlight
		$Icon.modulate = COLORLIST[player]
		if highlight_tween:
			highlight_tween.kill()
		if highlight:
			highlight_tween = create_tween()
			highlight_tween.set_loops()
			highlight_tween.tween_property($Icon, "modulate", Color.YELLOW, 1)
			highlight_tween.tween_property($Icon, "modulate", COLORLIST[player], 1)
#endregion

#region private variables
var highlight_tween
#endregion

#region public functions
func is_path():
	return true

func add_summon(summon):
	summon.reparent($DungobjContainer, false)
	summon.global_rotation = Vector3.ZERO
	summon.position = Vector3.ZERO

func move_to_dungeon():
	var base_tile = $RayCast3D.get_collider()
	base_tile.stack_path_tile(self)
#endregion

#region private functions
func set_player():
	# set player color
	$Icon.modulate = COLORLIST[player]
	var material = Globals.PLAYER_MATERIALS[player].duplicate()
	$MeshInstance3D.set_surface_override_material(0, material)
	# set mpnster lord
	if $DungobjContainer.get_child_count() >= 1:
		$DungobjContainer.get_child(0).queue_free()
	if monster_lord and player != 0:
		var monster_lord_obj = MonsterLord.instantiate()
		monster_lord_obj.player = player
		$DungobjContainer.add_child(monster_lord_obj)
#endregion
