extends VBoxContainer

# variables
var dicepool

# signals
signal roll_triplet_increased(idx, dice)
signal roll_triplet_decreased(idx)
signal info_button_pressed(card)

func _ready():
    # singal connections
    for dicecol in get_children():
        dicecol.connect("roll_button_pressed", self, "on_roll_button_pressed")
        dicecol.connect("roll_button_released", self, "on_roll_button_released")
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
func on_roll_button_pressed(dice):
    emit_signal("roll_triplet_increased", get_dice_idx(dice), dice)
    if roll_ready():
        disable_unselected()

func on_roll_button_released(dice):
    emit_signal("roll_triplet_decreased", get_dice_idx(dice))
    enable_undimensioned()

func on_info_button_pressed(card):
    emit_signal("info_button_pressed", card)

# private functions
func set_diceitems():
    for i in range(get_child_count()):
        get_child(i).set_dice(dicepool[i])

func get_dice_idx(dice):
    for i in range(get_child_count()):
        if get_child(i).dice == dice:
            return i

func roll_ready():
    var n = 0
    for dicecol in get_children():
        n += int(dicecol.selected)
    return n >= 3
