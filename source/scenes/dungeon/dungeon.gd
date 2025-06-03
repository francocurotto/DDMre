extends Node3D

#region constants
const DIMDICE_POS = Vector3(0, 1, -3)
#endregion

#region private variables
var dimdice = null
var tiles = []
#endregion

#region builtin functions
func _ready() -> void:
	Events.dimdice_selected.connect(on_dimdice_selected)
	for row in $Rows.get_children():
		for tile in row.get_children():
			tiles.append(tile)

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		var touch_pos = get_viewport().get_mouse_position()
		var camera = get_viewport().get_camera_3d()
		var ray_origin = camera.project_ray_origin(touch_pos)
		var ray_target = ray_origin + camera.project_ray_normal(touch_pos) * 1000
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_target)
		var result = space_state.intersect_ray(query)
		if result:
			var selected_object = result["collider"]
			if selected_object in tiles and dimdice:
				dimdice.position = selected_object.global_position + Vector3(0,1,0)
#endregion

#region signals callbacks
func on_dimdice_selected(new_dimdice):
	# remove previous dimdice
	if dimdice:
		dimdice.queue_free()
	# add dimdice to tree
	dimdice = new_dimdice
	add_child(dimdice)
	dimdice.position = DIMDICE_POS
#endregion
