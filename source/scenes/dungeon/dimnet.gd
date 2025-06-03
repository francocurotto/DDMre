extends RefCounted

#region constants
const NET_X = [
	Vector2i(0,1),
	Vector2i(-1,0), 
	Vector2i(0,0), 
	Vector2i(1,0),
	Vector2i(0,-1),
	Vector2i(0,-2)
]
#endregion

#region variables
var offset = Vector2i(0,0)
var coordinates :
	get():
		coordinates = NET_X
		return coordinates.map(func(x): return x+offset)
#endregion
