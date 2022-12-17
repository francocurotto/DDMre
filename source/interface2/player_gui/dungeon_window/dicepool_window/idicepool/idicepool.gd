extends VBoxContainer

# variables
var dicepool
var dice_buttons

# signals
signal dice_triplet_changed(dicepool_column)
signal dice_dim_button_pressed(dice)
signal dice_dim_button_released
signal info_button_pressed(card)

func _ready():
    # singal connections
    dice_buttons = get_children()
    for dice_button in dice_buttons:
        dice_button.connect("dice_roll_button_toggled", self, "on_dice_roll_button_toggled")
        dice_button.connect("dice_dim_button_pressed", self, "on_dice_dim_button_pressed")
        dice_button.connect("dice_dim_button_released", self, "on_dice_dim_button_released")
        dice_button.connect("info_button_pressed", self, "on_info_button_pressed")

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
    for dice_button in dice_buttons:
        dice_button.disable_roll()

func release_roll():
    for dice_button in dice_buttons:
        dice_button.release_roll()

func disable_roll_unselected():
    for dice_button in dice_buttons:
        if not dice_button.roll_selected:
            dice_button.disable_roll()

func enable_roll_undimensioned():
    for dice_button in dice_buttons:
        if not dice_button.dimensioned:
            dice_button.enable_roll()

func enable_dim_candidates(dim_candidates):
    for i in dim_candidates:
        get_child(i).enable_dim()

func disable_dim_dimensioned():
    for dice_button in dice_buttons:
        if dice_button.dimensioned:
            dice_button.disable_dim()

# signals callbacks
func on_dice_roll_button_toggled():
    if roll_ready():
        disable_roll_unselected()
    else:
        enable_roll_undimensioned()
    emit_signal("dice_triplet_changed", self)

func on_dice_dim_button_pressed(pressed_dice_button):
    for dice_button in get_children():
        if dice_button.dim_visible and dice_button != pressed_dice_button:
            dice_button.disable_dim()
    emit_signal("dice_dim_button_pressed", pressed_dice_button.dice)

func on_dice_dim_button_released():
    for dice_button in get_children():
        if dice_button.dim_visible:
            dice_button.enable_dim()
    emit_signal("dice_dim_button_released")

func on_info_button_pressed(card):
    emit_signal("info_button_pressed", card)

# private functions
func roll_ready():
    var n = 0
    for dice_button in get_children():
        n += int(dice_button.roll_selected)
    return n >= 3
