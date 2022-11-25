extends VBoxContainer

# variables
var dicepool

# signals
signal dice_triplet_changed(dicepool_column)
signal info_button_pressed(card)

func _ready():
    # singal connections
    for dicecol in get_children():
        dicecol.connect("dice_roll_button_toggled", self, "on_dice_roll_button_toggled")
        dicecol.connect("info_button_pressed", self, "on_info_button_pressed")

# setget functions
func set_dicepool(_dicepool):
    dicepool = _dicepool
    set_diceitems()

func set_diceitems():
    for i in range(get_child_count()):
        get_child(i).set_dice(dicepool[i])

func disable_roll():
    for dicecol in get_children():
        dicecol.disable_roll()

func disable_roll_unselected():
    for dicecol in get_children():
        if not dicecol.selected:
            dicecol.disable_roll()

func enable_roll_undimensioned():
    for dicecol in get_children():
        if not dicecol.dimensioned:
            dicecol.enable_roll()

func switch_to_dim(dim_candidates):
    for i in dim_candidates:
        get_child(i).switch_to_dim()

# public functions
func get_roll_indeces():
    var indeces = []
    for i in range(get_child_count()):
        if get_child(i).selected:
            indeces.append(i)
    return indeces

# signals callbacks
func on_dice_roll_button_toggled():
    emit_signal("dice_triplet_changed", self)
    if roll_ready():
        disable_roll_unselected()
    else:
        enable_roll_undimensioned()

func on_info_button_pressed(card):
    emit_signal("info_button_pressed", card)

# private functions
func roll_ready():
    var n = 0
    for dicecol in get_children():
        n += int(dicecol.selected)
    return n >= 3
