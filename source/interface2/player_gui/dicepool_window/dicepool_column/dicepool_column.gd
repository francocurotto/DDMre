extends VBoxContainer

# variables
var dicepool
var dimdice

# signals
signal info_button_pressed(card)

func _ready():
    # singal connections
    for dice in get_children():
        dice.connect("info_button_pressed", self, "on_info_button_pressed")

# setget functions
func set_dicepool(_dicepool, _dimdice):
    dicepool = _dicepool
    dimdice = _dimdice
    set_diceitems()
    #disable_dim_dimensioned()

# signals callbacks
func on_info_button_pressed(card):
    emit_signal("info_button_pressed", card)

# private functions
func set_diceitems():
    for i in range(get_child_count()):
        var dice = get_dice(i)
        dice.set_dice(dicepool[i])

func get_dice(idx):
    return get_child(idx)
