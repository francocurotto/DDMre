extends Node3D

#region constants
const DIMDICE_ROTATION_TIME = 0.1
#endregion

#region public functions
var dimdice :
	set(_dimdice):
		if dimdice: # get old dimdice info and remove
			_dimdice.position = dimdice.position
			_dimdice.basis = dimdice.basis
			dimdice.queue_free()
		# replace dimdice
		dimdice = _dimdice
		add_child(dimdice)
#endregion

#region private variables
var tiles = []
var dimtile
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
func rotate_dimdice_clockwise():
	var axis = Vector3(0, 1, 0)
	var rotated_basis = dimdice.transform.basis.rotated(axis, -PI/2)
	dimdice.tween_rotate(rotated_basis, DIMDICE_ROTATION_TIME)

func rotate_dimdice_counter_clockwise():
	var axis = Vector3(0, 1, 0)
	var rotated_basis = dimdice.transform.basis.rotated(axis, PI/2)
	dimdice.tween_rotate(rotated_basis, DIMDICE_ROTATION_TIME)

func flip_dimdice():
	var axis = Vector3(1, 0, 0)
	var rotated_basis = dimdice.transform.basis.rotated(axis, PI)
	dimdice.tween_rotate(rotated_basis, DIMDICE_ROTATION_TIME)
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
