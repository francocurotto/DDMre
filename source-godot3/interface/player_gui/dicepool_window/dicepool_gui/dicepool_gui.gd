extends PanelContainer

# variables
var dicepool
var dice_guis

# onready variables
onready var dicepool_vbox = $DicepoolGUIVBox/DiceGUIVBox

# signals
signal dicepool_gui_changed(dice_guis)
signal dice_gui_dim_button_pressed(dice_gui)
signal dice_gui_dim_button_released
signal dice_gui_info_button_pressed(card)

func _ready():
    # singal connections
    dice_guis = dicepool_vbox.get_children()
    for i in range(len(dice_guis)):
        var dice_gui = dice_guis[i]
        dice_gui.index = i
        dice_gui.connect("dice_gui_roll_button_toggled", self, "on_dice_gui_roll_button_toggled")
        dice_gui.connect("dice_gui_dim_button_pressed",  self, "on_dice_gui_dim_button_pressed")
        dice_gui.connect("dice_gui_dim_button_released", self, "on_dice_gui_dim_button_released")
        dice_gui.connect("dice_gui_info_button_pressed", self, "on_dice_gui_info_button_pressed")

# setget functions
func set_dicepool(_dicepool):
    dicepool = _dicepool
    set_diceitems()

func set_diceitems():
    for dice_gui in dice_guis:
        dice_gui.set_dice(dicepool[dice_gui.index])

func get_roll_indeces():
    var indeces = []
    for dice_gui in dice_guis:
        if dice_gui.roll_selected:
            indeces.append(dice_gui.index)
    return indeces

func get_selected_dim_index():
    for dice_gui in dice_guis:
        if dice_gui.dim_selected:
            return dice_gui.index

# public functions
func disable_roll():
    for dice_gui in dice_guis:
        dice_gui.disable_roll()

func release_roll():
    for dice_gui in dice_guis:
        dice_gui.release_roll()

func disable_roll_unselected():
    for dice_gui in dice_guis:
        if not dice_gui.roll_selected:
            dice_gui.disable_roll()

func enable_roll_undimensioned():
    for dice_gui in dice_guis:
        if not dice_gui.dimensioned:
            dice_gui.enable_roll()

func enable_dim_candidates(dim_candidates):
    for i in dim_candidates:
        dice_guis[i].enable_dim()

func disable_dim_dimensioned():
    for dice_gui in dice_guis:
        if dice_gui.dimensioned:
            dice_gui.disable_dim()

func roll_ready(): # TODO: optimize with gdscript4 reduce()
    var n = 0
    for dice_gui in dice_guis:
        n += int(dice_gui.roll_selected)
    return n >= 3

# signals callbacks
func on_dice_gui_roll_button_toggled():
    if roll_ready():
        disable_roll_unselected()
    else:
        enable_roll_undimensioned()
    emit_signal("dicepool_gui_changed", self)

func on_dice_gui_dim_button_pressed(pressed_dice_gui):
    for dice_gui in dice_guis:
        if dice_gui.dim_visible and dice_gui != pressed_dice_gui:
            dice_gui.disable_dim()
    emit_signal("dice_gui_dim_button_pressed", pressed_dice_gui.dice)

func on_dice_gui_dim_button_released():
    for dice_gui in dice_guis:
        if dice_gui.dim_visible:
            dice_gui.enable_dim()
    emit_signal("dice_gui_dim_button_released")

func on_dice_gui_info_button_pressed(card):
    emit_signal("dice_gui_info_button_pressed", card)
