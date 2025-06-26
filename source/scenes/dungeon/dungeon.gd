extends Node3D

#region constants
const DIMDICE_POS = Vector3(0, 2, -3)
#endregion

#region private variables
var tiles = []
var dimdice
var dimtile
#endregion

#region builtin functions
func _ready() -> void:
	Events.dimdice_selected.connect(on_dimdice_selected)
	dimtile = $Rows/Row4/BaseTile7
	for row in $Rows.get_children():
		tiles.append([])
		for tile in row.get_children():
			tiles[-1].append(tile)
#endregion

#region public functions
func get_touched_object(event: InputEvent, layer):
	var touch_pos = event.position
	var camera = get_viewport().get_camera_3d()
	var ray_origin = camera.project_ray_origin(touch_pos)
	var ray_target = ray_origin + camera.project_ray_normal(touch_pos) * 1000
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_target, layer)
	var result = space_state.intersect_ray(query)
	if result:
		return result["collider"]

func dungeon_touch(tile, net) -> void:
	if dimdice:
		dimtile = tile
		dimdice.position = dimtile.global_position + Vector3(0,2,0)
		set_dimnet(net)

func set_dimnet(net):
	var nettiles = get_nettiles(net)
	for row in tiles:
		for tile in row:
			tile.highlight = tile in nettiles
#endregion

#region signals callbacks
func on_dimdice_selected(new_dimdice, net):
	print(new_dimdice.rotation_index)
	# remove previous dimdice
	var dimdice_pos = DIMDICE_POS
	if dimdice:
		dimdice_pos = dimdice.position
		dimdice.queue_free()
	# add dimdice to tree
	dimdice = new_dimdice
	add_child(dimdice)
	dimdice.position = dimdice_pos
	set_dimnet(net)
#endregion

#region private functions
func get_nettiles(net):
	var nettiles = []
	var dimcoor = get_tilecoor(dimtile)
	net.offset = dimcoor
	for coor in net.coordinates:
		var tile = get_tile(coor)
		if tile:
			nettiles.append(tile)
	return nettiles

func get_tilecoor(tile):
	return Vector2i(tile.get_index(), tile.get_parent().get_index())

func get_tile(coor):
	if coor_in_bound(coor):
		return $Rows.get_child(coor.y).get_child(coor.x)

func coor_in_bound(coor):
	var in_bound_x = 0 <= coor.x and coor.x < Globals.DUNGEON_WIDTH
	var in_bound_y = 0 <= coor.y and coor.y < Globals.DUNGEON_HEIGHT
	return in_bound_x and in_bound_y
#endregion
