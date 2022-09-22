extends PanelContainer

# variables
var dicepool

# onready variables
onready var poolcont = $TPCont/PoolCont

# signals
signal roll_changed
signal mouse_entered_dice(idx)
signal mouse_exited_dice

func _ready():
    for idice in poolcont.get_children():
        idice.get_node("Button").connect("pressed", self, "on_diceitem_pressed")
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
        idice.set_index(i+1)

func get_indeces():
    var indeces = []
    for idice in poolcont.get_children():
        if idice.selected:
            # covert to engine idx
            var idx = Globals.int2diceidx(idice.index)
            indeces.append(idx)
    return indeces

# public functions
func enable_all():
    for idice in poolcont.get_children():
        idice.enable()

func disable_all():
    for idice in poolcont.get_children():
        idice.disable()

func release_all():
    for idice in poolcont.get_children():
        idice.release()

func roll_ready():
    return get_nselected() >= 3

# signals callback
func on_diceitem_pressed():
    emit_signal("roll_changed")
    if get_nselected() >= 3:
        disable_unselected()
    else:
        enable_unused()

func on_mouse_entered_diceitem(idice):
    var idx = idice.get_index()
    emit_signal("mouse_entered_dice", idx)

func on_mouse_exited_diceitem():
    emit_signal("mouse_exited_dice")

func get_nselected():
    var n = 0
    for idice in poolcont.get_children():
        n += int(idice.selected)
    return n

# private functions
func disable_unselected():
    for idice in poolcont.get_children():
        idice.disable_unselected()

func enable_unused():
    for idice in poolcont.get_children():
        idice.enable_unused()
