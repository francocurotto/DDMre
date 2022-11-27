extends HBoxContainer

# preload vatiables
var ISide = preload("res://interface2/player_gui/info_display/dice_line/sides/iside/iside.tscn")
var DiceFrame = preload("res://interface2/player_gui/info_display/dice_frame/dice_frame.tscn")

# setget functions
func set_roll(sides):
    free_children()
    for side in sides:
        add_iside(side)

# public functions
func update_dice(idicepool):
    var idx = 0
    # set dice frames
    for idice in idicepool.get_children():
        if idice.roll_selected:
            get_child(idx).set_dice(idice.dice)
            idx += 1
    # clear remaining dice frames
    for i in range(idx, get_child_count()):
        get_child(i).remove_dice()

func reset():
    free_children()
    for _i in range(3):
        add_child(DiceFrame.instance())

# private functions
func free_children():
    for child in get_children():
        remove_child(child) # maybe redundant
        child.free()

func add_iside(side):
    var iside = ISide.instance()
    iside.set_side(side)
    add_child(iside)
