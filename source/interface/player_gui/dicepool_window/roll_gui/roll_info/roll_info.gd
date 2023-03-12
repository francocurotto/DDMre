extends HBoxContainer

# preload vatiables
var SideInfo = preload("res://interface/player_gui/info_display/dice_info/sides/iside/iside.tscn")
var DiceRollInfo = preload("res://interface/player_gui/info_display/dice_frame/dice_frame.tscn")

# setget functions
func set_roll(sides):
    free_children()
    for side in sides:
        var side_info = SideInfo.instance()
        side_info.set_side(side)
        add_child(side_info)

# public functions
func update_dice(dicepool_gui):
    var i = 0
    # set dice frames
    for dice_gui in dicepool_gui.dice_guis:
        if dice_gui.roll_selected:
            get_child(i).set_dice(dice_gui.dice)
            i += 1
    # clear remaining dice frames
    for j in range(i, get_child_count()):
        get_child(j).remove_dice()

func reset():
    free_children()
    for _i in range(3):
        add_child(DiceRollInfo.instance())

# private functions
func free_children():
    for child in get_children():
        #remove_child(child) # maybe redundant
        child.free()
