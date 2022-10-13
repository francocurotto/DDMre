extends HBoxContainer

func set_sides_info(sides):
    for i in get_child_count():
        get_child(i).set_side(sides[i])
