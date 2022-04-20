extends Reference

const EmptyTile = preload("res://engine/dungeon/tiles/empty_tile.gd")
const HEIGHT = 19
const WIDTH  = 13

var array = []

func _init():
	init_array()

func init_array():
	for _i in range(HEIGHT):
		var row = []
		for _j in range(WIDTH):
			row.append(EmptyTile.new())
		array.append(row)
