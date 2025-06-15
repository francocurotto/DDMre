extends Node

#region constants
const NETCOORS = {
	"T" = [Vector2i(-1,1),Vector2i(0,1), Vector2i(1,1), Vector2i(0,0),Vector2i(0,-1),Vector2i(0,-2)],
	"Y" = [Vector2i(-1,1),Vector2i(0,1), Vector2i(0,0), Vector2i(0,1),Vector2i(0,-1),Vector2i(0,-2)],
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
var offset
var coordinates:
	get():
		var coor = NETCOORS[type]
		coor = set_offset(coor)
		return coor
#endregion

#region private functions
func set_offset(coor):
	return coor.map(func(x): return x+offset)
#endregion
