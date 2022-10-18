extends HBoxContainer

func set_info(kwargs):
    var sides = kwargs["sides"]
    for i in get_child_count():
        get_child(i).set_side(sides[i])
