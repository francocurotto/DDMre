extends Node3D

#region constants
const DIMDICE_POS = Vector3(0, 2, -3)
#endregion

#region private variables
var tiles = []
var dimdice
var dimtile
var dimdice_rot_quat_previous = Quaternion()
var dimdice_rot_quat_current = Quaternion()
#endregion

#region builtin functions
func _ready() -> void:
	dimtile = $Rows/Row4/BaseTile7
	for row in $Rows.get_children():
		tiles.append([])
		for tile in row.get_children():
			tiles[-1].append(tile)
#endregion

#region public functions
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
func update_dimdice(new_dimdice, net):
	# remove previous dimdice
	var dimdice_pos = DIMDICE_POS
	if dimdice:
		dimdice_pos = dimdice.position
		dimdice.queue_free()
	# add dimdice to tree
	dimdice = new_dimdice
	add_child(dimdice)
	dimdice.position = dimdice_pos
	#dimdice.rotation = Vector3(0, 0, 0)
	dimdice.basis = Basis(dimdice_rot_quat_current)
	set_dimnet(net)

func rotate_dimdice_clockwise():
	dimdice_rot_quat_previous = dimdice.transform.basis.get_rotation_quaternion()
	var axis = Vector3(0, 1, 0)
	dimdice_rot_quat_current = dimdice.transform.basis.rotated(axis, -PI/2)
	var tween = create_tween()
	tween.tween_method(_apply_quat_rotation, 0.0, 1.0, 0.1)

func rotate_dimdice_counter_clockwise():
	dimdice_rot_quat_previous = dimdice.transform.basis.get_rotation_quaternion()
	var axis = Vector3(0, 1, 0)
	dimdice_rot_quat_current = dimdice.transform.basis.rotated(axis, PI/2)
	var tween = create_tween()
	tween.tween_method(_apply_quat_rotation, 0.0, 1.0, 0.1)

func flip_dimdice():
	dimdice_rot_quat_previous = dimdice.transform.basis.get_rotation_quaternion()
	var axis = Vector3(1, 0, 0)
	dimdice_rot_quat_current = dimdice.transform.basis.rotated(axis, PI)
	var tween = create_tween()
	tween.tween_method(_apply_quat_rotation, 0.0, 1.0, 0.1)
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

func _apply_quat_rotation(t: float) -> void:
	var q = dimdice_rot_quat_previous.slerp(dimdice_rot_quat_current, t)
	dimdice.basis = Basis(q)
#endregion
