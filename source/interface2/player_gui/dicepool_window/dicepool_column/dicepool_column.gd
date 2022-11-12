extends VBoxContainer

# variables
var dicepool

# signals
signal roll_triplet_changed(dicepool_column)
signal info_button_pressed(card)

func _ready():
    # singal connections
    for dicecol in get_children():
        dicecol.connect("roll_button_toggled", self, "on_roll_button_toggled")
        dicecol.connect("info_button_pressed", self, "on_info_button_pressed")

# setget functions
func set_dicepool(_dicepool):
    dicepool = _dicepool
    set_diceitems()
    #disable_dim_dimensioned()

func disable_unselected():
    for dicecol in get_children():
        if not dicecol.selected:
            dicecol.disable()

func enable_undimensioned():
    for dicecol in get_children():
        if not dicecol.dimensioned:
            dicecol.enable()

# signals callbacks
func on_roll_button_toggled():
    emit_signal("roll_triplet_changed", self)
    if roll_ready():
        disable_unselected()
    else:
        enable_undimensioned()

func on_info_button_pressed(card):
    emit_signal("info_button_pressed", card)

# private functions
func set_diceitems():
    for i in range(get_child_count()):
        get_child(i).set_dice(dicepool[i])

func roll_ready():
    var n = 0
    for dicecol in get_children():
        n += int(dicecol.selected)
    return n >= 3
