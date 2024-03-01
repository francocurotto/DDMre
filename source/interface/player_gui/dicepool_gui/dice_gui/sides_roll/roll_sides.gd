extends MarginContainer

# constants
const SideInfo = preload("res://interface/player_gui/dicepool_gui/sides_info/side_info/side_info.tscn")

# variables
var type
var sides
var sides_set = []

# signals
signal roll_finished

# public functions
func setup(dice):
    type = dice.card.type
    sides = dice.sides
    fill_sides_set()
    add_side_infos()

func roll(side, turns):
    # sides indeces
    var side_indeces = range(len(sides_set))
    # perform rolls
    for _i in turns:
        # get a random index for a side taking care it does not repeat two times in a row
        var i = side_indeces.pop_at(randi()%len(sides_set)-1)
        side_indeces.push_back(i)
        hide_all_sides()
        get_child(i).visible = true
        await get_tree().create_timer(0.03).timeout
    # last roll with final side
    hide_all_sides()
    for i in len(sides_set):
        if sides_set[i].is_equal(side):
            get_child(i).visible = true
            break
    roll_finished.emit()

# private functions
func fill_sides_set():
    for side in sides:
        if not side.in_array(sides_set):
            sides_set.append(side)

func add_side_infos():
    for side in sides_set:
        var side_info = SideInfo.instantiate()
        side_info.setup(type, side)
        add_child(side_info)

func hide_all_sides():
    for side_info in get_children():
        side_info.visible = false
