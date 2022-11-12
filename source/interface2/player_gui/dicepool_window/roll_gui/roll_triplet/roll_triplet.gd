extends HBoxContainer

# public functions
func update_dice(idicepool):
    var idx = 0
    # set dice frames
    for idice in idicepool.get_children():
        if idice.selected:
            get_child(idx).set_dice(idice.dice)
            idx += 1
    # clear remaining dice frames
    for i in range(idx, get_child_count()):
        get_child(i).remove_dice()
