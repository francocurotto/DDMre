extends HBoxContainer

# setget functions
func set_sides(sides):
    for i in get_child_count():
        get_child(i).set_side(sides[i])
