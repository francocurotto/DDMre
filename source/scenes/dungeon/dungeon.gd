extends Node3D

#region constants
const DIMDICE_ROTATION_TIME = 0.1
const DIMDICE_RETURN_TIME = 0.5
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
		add_child(dimdice)
#endregion

#region private variables
var tiles = []
#endregion

#region builtin functions
func _enter_tree() -> void:
	Globals.dungeon = self

func _ready() -> void:
	# initail conditions for dungeon
	$Rows/Row1/BaseTile7.add_path_tile(1)
	$Rows/Row1/BaseTile7.overtile.monster_lord = true
	$Rows/Row19/BaseTile7.add_path_tile(2)
	$Rows/Row19/BaseTile7.overtile.monster_lord = true
	for row in $Rows.get_children():
		for tile in row.get_children():
			tiles.append(tile)
#endregion

#region public functions
func set_dimnet(net, dimcoor):
	var net_tiles = get_net_tiles(net, dimcoor)
	for tile in tiles:
		tile.highlight = tile in net_tiles

func move_dimdice(velocity, player, net, return_position):
	dimdice.position.y -= DIMDICE_DRAG_SPEED * velocity.y
	if dimdice.position.y < Globals.DIMDICE_HEIGHT:
		if can_dimension(player, net):
			dimension_the_dice(net)
		else:
			return_dimdice(return_position, true)

func return_dimdice(return_position, shake=false):
	dimdice.dimdice_movement_started.emit()
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(dimdice, "position", return_position, DIMDICE_RETURN_TIME)
	if shake:
		tween.set_parallel()
		tween.tween_method(apply_dimdice_shake, 0.0, 1.0, DIMDICE_RETURN_TIME)
	await tween.finished
	dimdice.dimdice_movement_finished.emit()
#endregion

#region signals callbacks
func on_tile_touched(tile, dimdice_position, net) -> void:
	#TODO: would this allow for opponent player to move dimdice?
	if dimdice:
		dimdice.position = dimdice_position
		set_dimnet(net, get_tilecoor(tile))

func rotate_dimdice_clockwise():
	var axis = Vector3(0, 1, 0)
	var rotated_quat = Quaternion(dimdice.basis.rotated(axis, -PI/2))
	dimdice.tween_rotate(rotated_quat, DIMDICE_ROTATION_TIME)

func rotate_dimdice_counter_clockwise():
	var axis = Vector3(0, 1, 0)
	var rotated_quat = Quaternion(dimdice.basis.rotated(axis, PI/2))
	dimdice.tween_rotate(rotated_quat, DIMDICE_ROTATION_TIME)

func flip_dimdice(player):
	var orientation = 3-2*player
	var axis = Vector3(orientation, 0, 0)
	var rotated_basis = dimdice.transform.basis.rotated(axis, PI)
	dimdice.tween_rotate(rotated_basis, DIMDICE_ROTATION_TIME)
#endregion

#region private functions
func get_net_tiles(net, dimcoor):
	var net_tiles = []
	net.offset = dimcoor
	for coor in net.coordinates:
		var tile = get_tile(coor)
		if tile:
			net_tiles.append(tile)
	return net_tiles

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
		if not get_tile(coor).is_empty():
			return true
	return false

func net_connects_with_path(player, net):
	for coor in net.coordinates:
		var neighbor_tiles = get_neighbor_tiles(coor)
		for tile in neighbor_tiles:
			if tile.has_path() and tile.overtile.player == player:
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

func dimension_the_dice(net):
	dimdice.unfold(net)
	for tile in tiles:
		tile.highlight = false

func apply_dimdice_shake(t: float) -> void:
	var angle = 0.2*sin(10*2*PI*t)
	var shaked_basis = Basis(dimdice.tween_quat1).rotated(Vector3.BACK, angle)
	dimdice.basis = shaked_basis
#endregion
