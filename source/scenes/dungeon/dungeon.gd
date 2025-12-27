extends Node3D

#region constants
const DIMDICE_ROTATION_TIME = 0.1
const DIMDICE_RETURN_TIME = 0.5
const DIMDICE_DRAG_SPEED = 0.0002
const MONSTER_MOVE_TIME = 0.2
#endregion

#region preloads
const MovePathQueue = preload("res://scenes/dungeon/path_queue/move_path_queue.gd")
const AttackPathQueue = preload("res://scenes/dungeon/path_queue/attack_path_queue.gd")
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
var base_tiles = []
var move_cost = 1
#endregion

#region builtin functions
func _enter_tree() -> void:
	Globals.dungeon = self

func _ready() -> void:
	for row in $Rows.get_children():
		for tile in row.get_children():
			base_tiles.append(tile)
#endregion

#region public functions
func set_initial(dunginit):
	# set initial dungeon layout
	for i in Globals.DUNGEON_HEIGHT:
		for j in Globals.DUNGEON_WIDTH:
			var coor = Vector2i(j, Globals.DUNGEON_HEIGHT-i-1)
			var tile = get_tile(coor)
			match dunginit["DUNGEON"][i][j]:
				"O": 
					pass
				"X":
					tile.add_block_tile()
				"l":
					tile.add_path_tile(1)
					tile.overtile.monster_lord = true
					if dunginit.has("HEART1"):
						var monster_lord = tile.overtile.content
						monster_lord.hearts = dunginit["HEARTS1"]
				"L":
					tile.add_path_tile(2)
					tile.overtile.monster_lord = true
					if dunginit.has("HEART2"):
						var monster_lord = tile.overtile.content
						monster_lord.hearts = dunginit["HEARTS2"]
				"p":
					tile.add_path_tile(1)
				"P":
					tile.add_path_tile(2)
				"N":
					tile.add_path_tile(0)
	# set initial summons
	if dunginit.has("SUMMONS1"):
		set_initial_summons(dunginit["SUMMONS1"], 1)
	if dunginit.has("SUMMONS2"):
		set_initial_summons(dunginit["SUMMONS2"], 2)

func set_dimnet(net, dimcoor):
	var net_tiles = get_net_tiles(net, dimcoor)
	for tile in base_tiles:
		tile.highlight = tile in net_tiles

func move_dimdice(velocity, player, net, return_position):
	dimdice.position.y -= DIMDICE_DRAG_SPEED * velocity.y
	if dimdice.position.y < Globals.DIMENSION_HEIGHT:
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

func remove_dimdice():
	remove_tiles_highlight()
	if dimdice:
		dimdice.queue_free()

func activate_move_tiles(monster):
	var move_path_queue = MovePathQueue.new(self, monster)
	var move_tiles = move_path_queue.tiles
	for tile in move_tiles:
		tile.highlight = true

func activate_attack_tiles(monster):
	var attack_path_queue = AttackPathQueue.new(self, monster)

func activate_selected_move_path(monster, tile):
	remove_tiles_highlight()
	var move_path_queue = MovePathQueue.new(self, monster)
	var path = move_path_queue.get_path(tile)
	for path_tile in path:
		path_tile.highlight = true
	return path

func get_max_move_tiles(monster):
	var player_gui = Globals.duel.player_guis[monster.player]
	var move_crests = player_gui.dice_gui.crestpool.sides_dict["MOVEMENT"].amount
	return min(floor(move_crests/move_cost*monster.speed), monster.max_move)

func get_move_cost(path, monster):
	var move_tiles = len(path)-1 
	return ceil(move_tiles/monster.speed*move_cost)

func move_monster(monster, move_path):
	var tween = create_tween()
	for tile in move_path.slice(1):
		var pos_x = tile.global_position.x
		var pos_z = tile.global_position.z
		var new_pos = Vector3(pos_x, monster.global_position.y, pos_z)
		tween.tween_property(monster, "global_position", new_pos, MONSTER_MOVE_TIME)
	await tween.finished
	move_path[-1].overtile.add_summon(monster)
	remove_tiles_highlight()
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
func set_initial_summons(summons, player):
	for summon_dict in summons:
		var coor = pos_to_coor(summon_dict["POS"])
		var diceidx = summon_dict["DICE"] - 1
		# get summon from dice and mark not available
		var dicepool = Globals.duel.player_guis[player].dice_gui.dicepool
		var dice_button = dicepool.buttons[diceidx]
		var summon = dice_button.dice.summon
		var tile = get_tile(coor)
		if tile.has_path():
			dice_button.available = false
			tile.overtile.add_summon(summon)
			summon.tween_dimension(create_tween())

func pos_to_coor(pos):
	return Vector2i(ord(pos[0])-97, int(pos.substr(1))-1)

func get_tilecoor(tile):
	return Vector2i(tile.get_index(), tile.get_parent().get_index())

func get_tile(coor):
	if coor_in_bound(coor):
		return $Rows.get_child(coor.y).get_child(coor.x)

func get_summon_tile(summon):
	for tile in base_tiles:
		if tile.dungobj and tile.dungobj == summon:
			return tile

func get_net_tiles(net, dimcoor):
	var net_tiles = []
	net.offset = dimcoor
	for coor in net.coordinates:
		var tile = get_tile(coor)
		if tile:
			net_tiles.append(tile)
	return net_tiles

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
	remove_tiles_highlight()

func remove_tiles_highlight():
	for tile in base_tiles:
		tile.highlight = false

func apply_dimdice_shake(t: float) -> void:
	var angle = 0.2*sin(10*2*PI*t)
	var shaked_basis = Basis(dimdice.tween_quat1).rotated(Vector3.BACK, angle)
	dimdice.basis = shaked_basis
#endregion
