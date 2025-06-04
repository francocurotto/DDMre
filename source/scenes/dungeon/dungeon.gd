extends Node3D

#region constants
const DIMDICE_POS = Vector3(0, 1, -3)
const DimNet = preload("res://scenes/dungeon/dimnet.gd")
#endregion

#region private variables
var dimdice = null
var tiles = []
var dimnet = DimNet.new()
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
func dungeon_touch(_event: InputEvent) -> void:
	var touch_pos = get_viewport().get_mouse_position()
	var camera = get_viewport().get_camera_3d()
	var ray_origin = camera.project_ray_origin(touch_pos)
	var ray_target = ray_origin + camera.project_ray_normal(touch_pos) * 1000
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_target, 2)
	var result = space_state.intersect_ray(query)
	if result and dimdice:
		dimtile = result["collider"]
		dimdice.position = dimtile.global_position + Vector3(0,1,0)
		set_dimnet()
#endregion

#region signals callbacks
func on_dimdice_selected(new_dimdice):
	# remove previous dimdice
	var dimdice_pos = DIMDICE_POS
	if dimdice:
		dimdice_pos = dimdice.position
		dimdice.queue_free()
	# add dimdice to tree
	dimdice = new_dimdice
	add_child(dimdice)
	dimdice.position = dimdice_pos
	set_dimnet()
#endregion

#region private functions
func set_dimnet():
	var nettiles = get_nettiles()
	for row in tiles:
		for tile in row:
			tile.highlight = tile in nettiles

func get_nettiles():
	var nettiles = []
	var dimcoor = get_tilecoor(dimtile)
	dimnet.offset = dimcoor
	for coor in dimnet.coordinates:
		var tile = get_tile(coor)
		if tile:
			nettiles.append(tile)
	return nettiles

func get_tilecoor(tile):
	return Vector2i(tile.get_index(), tile.get_parent().get_index())

func get_tile(coor):
	return $Rows.get_child(coor.y).get_child(coor.x)
#endregion
