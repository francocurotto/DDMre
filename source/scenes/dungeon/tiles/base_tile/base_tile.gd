@tool
extends StaticBody3D

#region constants
const COLOR = Color(0.2,0.2,0.3)
const PathTile = preload("res://scenes/dungeon/tiles/path_tile/path_tile.tscn")
const BlockTile = preload("res://scenes/dungeon/tiles/block_tile/block_tile.tscn")
#endregion

#region export variables
#@export_enum("EMPTY", "PATH", "BLOCK") var type : String = "EMPTY" :
	#set(_type):
		#type = _type
		#if $TileContainer.get_child_count() >= 1:
			#$TileContainer.get_child(0).queue_free()
		#if type == "PATH":
			#var path_tile = PathTile.instantiate()
			#path_tile.player = player
			#$TileContainer.add_child(path_tile)
		#elif type == "BLOCK":
			#$TileContainer.add_child(BlockTile.instantiate())
#
#@export_range(0,2) var player : int = 1 :
	#set(_player):
		#player = _player
		#if type == "PATH":
			#var path_tile = $TileContainer.get_child(0)
			#path_tile.player = player
#
#@export var monster_lord : bool :
	#set(_monster_lord):
		#monster_lord = _monster_lord
		#if type == "PATH":
			#var path_tile = $TileContainer.get_child(0)
			#path_tile.monster_lord = monster_lord

@export var highlight : bool = false :
	set(_highlight):
		highlight = _highlight
		$Sprite3D.modulate = COLOR
		if highlight_tween:
			highlight_tween.kill()
		if highlight:
			highlight_tween = create_tween()
			highlight_tween.set_loops()
			highlight_tween.tween_property($Sprite3D, "modulate", Color.YELLOW, 1)
			highlight_tween.tween_property($Sprite3D, "modulate", COLOR, 1)
		# highligh overtile if exists
		if overtile:
			overtile.highlight = highlight
#endregion

#region public variable
var overtile :
	get():
		if $TileContainer.get_child_count() >= 1:
			return $TileContainer.get_child(0)
		return null
#endregion

#region private variables
var highlight_tween
#endregion

#region public fuctions
func add_path_tile(player):
	if not overtile:
		var path_tile = PathTile.instantiate()
		path_tile.player = player
		$TileContainer.add_child(path_tile)

func add_block_tile():
	if not overtile:
		$TileContainer.add_child(BlockTile.instantiate())

func stack_path_tile(path_tile):
	if not overtile:
		path_tile.reparent($TileContainer)
		# adjust to excpected position
		path_tile.position = Vector3(0, 0, 0)

func is_empty():
	return overtile == null

func has_path():
	return overtile and overtile.is_path()
#endregion
