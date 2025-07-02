extends RefCounted

#region constants
const NETCOORS = {
	"T" = [Vector2i(-1,1),Vector2i(0,1), Vector2i(1,1), Vector2i(0,0),Vector2i(0,-1),Vector2i(0,-2)],
	"Y" = [Vector2i(-1,1),Vector2i(0,1), Vector2i(0,0), Vector2i(1,0),Vector2i(0,-1),Vector2i(0,-2)],
	"Z" = [Vector2i(-1,1),Vector2i(0,1), Vector2i(0,0), Vector2i(0,-1),Vector2i(0,-2),Vector2i(1,-2)],
	"V" = [Vector2i(-1,1),Vector2i(0,1), Vector2i(0,0), Vector2i(0,-1),Vector2i(1,-1),Vector2i(0,-2)],
	"X" = [Vector2i(0,1),Vector2i(-1,0), Vector2i(0,0), Vector2i(1,0),Vector2i(0,-1),Vector2i(0,-2)],
	"N" = [Vector2i(0,1),Vector2i(-1,0), Vector2i(0,0), Vector2i(0,-1),Vector2i(1,-1),Vector2i(0,-2)],
	"M" = [Vector2i(-1,1),Vector2i(0,1), Vector2i(0,0), Vector2i(0,-1),Vector2i(1,-1),Vector2i(1,-2)],
	"E" = [Vector2i(-1,1),Vector2i(-1,0), Vector2i(0,0), Vector2i(0,-1),Vector2i(1,-1),Vector2i(1,-2)],
	"P" = [Vector2i(-1,1),Vector2i(-1,0), Vector2i(0,0), Vector2i(1,0),Vector2i(0,-1),Vector2i(0,-2)],
	"R" = [Vector2i(-1,1),Vector2i(-1,0), Vector2i(0,0), Vector2i(0,-1),Vector2i(1,-1),Vector2i(0,-2)],
	"L" = [Vector2i(0,2),Vector2i(0,1), Vector2i(0,0), Vector2i(1,0),Vector2i(1,-1),Vector2i(1,-2)],
}
#endregion

#region public variables
var type
var rotation = 0
var orientation = 1
var offset
var coordinates:
	get():
		var coor = NETCOORS[type]
		coor = apply_rotation(coor)
		coor = apply_orientation(coor)
		coor = apply_offset(coor)
		return coor
#endregion

#region public functions
func rotate_clockwise():
	rotation = posmod(rotation+orientation, 4)

func rotate_counter_clockwise():
	rotation = posmod(rotation-orientation, 4)

func flip():
	orientation *= -1
#endregion

#region private functions
func apply_offset(coor):
	return coor.map(func(v): return v+offset)

func apply_rotation(coor):
	for i in rotation:
		coor = coor.map(func(v): return Vector2i(v.y,-v.x))
	return coor

func apply_orientation(coor):
	if orientation == -1:
		coor = coor.map(func(v): return Vector2i(v.x, -v.y))
	return coor
#endregion
