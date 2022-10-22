extends PanelContainer

# constants
const SkipMenu = preload("res://interface/player_gui/dicepool/skip_menu/skip_menu.tscn")

# variables
var dicepool
var skip_menu

# onready variables
onready var poolcont = $TPCont/PoolCont

# signals
signal roll_changed
signal mouse_entered_dice(idx)
signal mouse_exited_dice
signal skip_input
signal dimdice_selected(idx)
signal dimdice_unselected

func _ready():
    for idice in poolcont.get_children():
        idice.get_node("RollButton").connect("pressed", self, "on_roll_button_pressed")
        idice.connect("dim_button_pressed", self, "on_dim_button_pressed")
        idice.connect("dim_button_released", self, "on_dim_button_released")
        idice.connect("mouse_entered_diceitem", self, "on_mouse_entered_diceitem")
        idice.connect("mouse_exited_diceitem", self, "on_mouse_exited_diceitem")

# setget functions
func set_dicepool(_dicepool):
    dicepool = _dicepool
    set_diceitems()

func set_diceitems():
    for i in range(dicepool.size()):
        var idice = poolcont.get_child(i)
        idice.set_dice(dicepool[i])
        idice.set_index(i)

func get_roll_indeces():
    var indeces = []
    for i in range(poolcont.get_child_count()):
        if poolcont.get_child(i).roll_selected:
            indeces.append(i)
    return indeces

func enable_roll_all():
    for idice in poolcont.get_children():
        idice.enable_roll()

func disable_roll_all():
    for idice in poolcont.get_children():
        idice.disable_roll()

func release_roll_all():
    for idice in poolcont.get_children():
        idice.release_roll()

func enable_dim_all():
    for idice in poolcont.get_children():
        idice.enable_dim()

func disable_dim_all():
    for idice in poolcont.get_children():
        idice.disable_dim()

func enable_dim_candidates(dim_candidates):
    for i in dim_candidates:
        var idice = poolcont.get_child(i)
        idice.switch_to_dim_button()

func switch_to_roll_button_all():
    for idice in poolcont.get_children():
        idice.switch_to_roll_button()

# public functions
func roll_ready():
    return get_nroll_selected() >= 3

# signals callback
func on_roll_button_pressed():
    emit_signal("roll_changed")
    if get_nroll_selected() >= 3:
        disable_roll_unselected()
    else:
        enable_roll_unused()

func on_dim_button_pressed(idx):
    for i in range(poolcont.get_child_count()):
        if i != idx:
            poolcont.get_child(i).disable_dim()
    emit_signal("dimdice_selected", idx)

func on_dim_button_released():
    for idice in poolcont.get_children():
        idice.enable_dim()
    emit_signal("dimdice_unselected")

func on_mouse_entered_diceitem(idice):
    var idx = idice.get_index()
    emit_signal("mouse_entered_dice", idx)

func on_mouse_exited_diceitem():
    emit_signal("mouse_exited_dice")

func on_skipmenu_skip_pressed():
    skip_menu.queue_free()
    emit_signal("skip_input")
    
func on_skipmenu_cancel_pressed():
    skip_menu.queue_free()
    enable_dim_all()
    
# private functions
func get_nroll_selected():
    var n = 0
    for idice in poolcont.get_children():
        n += int(idice.roll_selected)
    return n

func disable_roll_unselected():
    for idice in poolcont.get_children():
        idice.disable_roll_unselected()

func enable_roll_unused():
    for idice in poolcont.get_children():
        idice.enable_roll_unused()

func create_skip_menu():
    disable_dim_all()
    skip_menu = SkipMenu.instance()
    add_child(skip_menu)
    skip_menu.connect("skipmenu_skip_pressed", self, "on_skipmenu_skip_pressed")
    skip_menu.connect("skipmenu_cancel_pressed", self, "on_skipmenu_cancel_pressed")  
