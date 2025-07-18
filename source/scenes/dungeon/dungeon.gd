extends Node3D

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

func return_dimdice(return_position):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(dimdice, "position", return_position, 0.5)
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
		reject_dimension(return_position)
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

func can_dimension(_player, _net):
	#TODO
	return false

func dimension_the_dice():
	#TODO 
	pass

func reject_dimension(return_position):
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(dimdice, "position", return_position, 0.5)
#endregion
