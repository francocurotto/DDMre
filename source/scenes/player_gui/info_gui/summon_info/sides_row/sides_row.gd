extends HBoxContainer

#region public functions
func set_sides(sides, type):
	for i in len(sides):
		get_child(i).set_side(sides[i], type)
#endregion
