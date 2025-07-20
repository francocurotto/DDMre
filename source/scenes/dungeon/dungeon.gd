extends Node3D

#region signals
signal dimension_started
#endregion

#region constants
const DIMDICE_ROTATION_TIME = 0.1
const DIMDICE_DRAG_SPEED = 0.0002
#endregion

#region public variables
var dimdice :
	set(_dimdice):
		if dimdice: # get old dimdice info and remove
			_dimdice.position = dimdice.position
			_dimdice.basis = dimdice.basis
			dimdice.queue_free()
		# replace dimdice
		dimdice = _dimdice
		dimdice.contact_monitor = true
		dimdice.max_contacts_reported = 1
		add_child(dimdice)
#endregion

#region private variables
var tiles = []
var dimtile
#endregion

#region builtin functions
func _enter_tree() -> void:
	Globals.dungeon = self

func _ready() -> void:
	dimtile = $Rows/Row4/BaseTile7
	for row in $Rows.get_children():
		tiles.append([])
		for tile in row.get_children():
			tiles[-1].append(tile)
#endregion

#region public functions
func on_tile_touched(tile, dimdice_position, net) -> void:
	if dimdice:
		dimtile = tile
		dimdice.position = dimdice_position
		set_dimnet(net)

func set_dimnet(net):
	var nettiles = get_nettiles(net)
	for row in tiles:
		for tile in row:
			tile.highlight = tile in nettiles

func move_dimdice(velocity):
	dimdice.position.y -= DIMDICE_DRAG_SPEED * velocity.y

func return_dimdice(return_position, shake=false):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(dimdice, "position", return_position, 0.5)
	if shake:
		tween.parallel().tween_method(apply_dimdice_shake, 0.0, 1.0, 0.5)
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

func on_dimdice_collided(player, net, return_position):
	if can_dimension(player, net):
		dimension_the_dice()
	else:
		return_dimdice(return_position, true)
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

func can_dimension(player, net):
	# first check if net is inbound to not get null later at get_tile
	if not net.coordinates.all(coor_in_bound):
		return false
	return not net_overlaps(net) and net_connects_with_path(player, net)

func net_overlaps(net):
	for coor in net.coordinates:
		if get_tile(coor).type != "EMPTY":
			return true
	return false

func net_connects_with_path(player, net):
	for coor in net.coordinates:
		var neighbor_tiles = get_neighbor_tiles(coor)
		for tile in neighbor_tiles:
			if tile.type == "PATH" and tile.player == player:
				return true
	return false

func get_neighbor_tiles(coor):
	var directions = [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN]
	var neighbor_tiles = []
	for direction in directions:
		var neighbor_coor = coor + direction
		var neighbor_tile = get_tile(neighbor_coor)
		if neighbor_tile: # check not null
			neighbor_tiles.append(neighbor_tile)
	return neighbor_tiles

func dimension_the_dice():
	dimension_started.emit()
	dimdice.position.y = 0.5
	dimdice.basis = dimdice.basis_to
	pass
	#TODO finish

func apply_dimdice_shake(t: float) -> void:
	var angle = 0.2*sin(10*2*PI*t)
	var shaked_basis = dimdice.basis_to.rotated(Vector3.BACK, angle)
	dimdice.basis = shaked_basis
#endregion
