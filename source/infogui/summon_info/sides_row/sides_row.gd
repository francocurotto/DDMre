extends HBoxContainer

#region public functions
func set_sides(sides, type):
	for i in sides.get_child_count():
		get_child(i).set_side(sides.get_child(i), type)
#endregion
