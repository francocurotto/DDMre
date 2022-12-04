extends VBoxContainer

# variables
var dicepool
var dicecols

# signals
signal dice_triplet_changed(dicepool_column)
signal dice_dim_button_pressed
signal dice_dim_button_released
signal info_button_pressed(card)

func _ready():
    # singal connections
    dicecols = get_children()
    for dicecol in get_children():
        dicecol.connect("dice_roll_button_toggled", self, "on_dice_roll_button_toggled")
        dicecol.connect("dice_dim_button_pressed", self, "on_dice_dim_button_pressed")
        dicecol.connect("dice_dim_button_released", self, "on_dice_dim_button_released")
        dicecol.connect("info_button_pressed", self, "on_info_button_pressed")

# setget functions
func set_dicepool(_dicepool):
    dicepool = _dicepool
    set_diceitems()

func set_diceitems():
    for i in range(get_child_count()):
        get_child(i).set_dice(dicepool[i])

func get_roll_indeces():
    var indeces = []
    for i in range(get_child_count()):
        if get_child(i).roll_selected:
            indeces.append(i)
    return indeces

func get_selected_dim_idx():
    for i in range(get_child_count()):
        if get_child(i).dim_selected:
            return i

# public functions
func disable_roll():
    for dicecol in dicecols:
        dicecol.disable_roll()

func release_roll():
    for dicecol in dicecols:
        dicecol.release_roll()

func disable_roll_unselected():
    for dicecol in dicecols:
        if not dicecol.roll_selected:
            dicecol.disable_roll()

func enable_roll_undimensioned():
    for dicecol in dicecols:
        if not dicecol.dimensioned:
            dicecol.enable_roll()

func enable_dim_candidates(dim_candidates):
    for i in dim_candidates:
        get_child(i).enable_dim()

func disable_dim_dimensioned():
    for dicecol in dicecols:
        if dicecol.dimensioned:
            dicecol.disable_dim()

# signals callbacks
func on_dice_roll_button_toggled():
    if roll_ready():
        disable_roll_unselected()
    else:
        enable_roll_undimensioned()
    emit_signal("dice_triplet_changed", self)

func on_dice_dim_button_pressed(pressed_dicecol):
    for dicecol in get_children():
        if dicecol.dim_visible and dicecol != pressed_dicecol:
            dicecol.disable_dim()
    emit_signal("dice_dim_button_pressed")

func on_dice_dim_button_released():
    for dicecol in get_children():
        if dicecol.dim_visible:
            dicecol.enable_dim()
    emit_signal("dice_dim_button_released")

func on_info_button_pressed(card):
    emit_signal("info_button_pressed", card)

# private functions
func roll_ready():
    var n = 0
    for dicecol in get_children():
        n += int(dicecol.roll_selected)
    return n >= 3
