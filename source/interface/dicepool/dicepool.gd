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
    for ditem in poolcont.get_children():
        ditem.get_node("Button").connect("pressed", self, "on_diceitem_pressed")
        ditem.connect("mouse_entered_diceitem", self, "on_mouse_entered_diceitem")
        ditem.connect("mouse_exited_diceitem", self, "on_mouse_exited_diceitem")

# set functions
func set_dicepool(_dicepool):
    dicepool = _dicepool
    set_diceitems()

func set_diceitems():
    for i in range(dicepool.size()):
        var diceitem = poolcont.get_child(i)
        diceitem.set_dice(dicepool[i])
        diceitem.set_index(i)

# public functions
func enable_all():
    for diceitem in poolcont.get_children():
        diceitem.enable()

func disable_all():
    for diceitem in poolcont.get_children():
        diceitem.disable()

func release_all():
    for diceitem in poolcont.get_children():
        diceitem.release()

func roll_ready():
    return get_nselected() >= 3

func get_indeces():
    var indeces = []
    for i in poolcont.get_child_count():
        var diceitem = poolcont.get_child(i)
        if diceitem.selected:
            indeces.append(i)
    return indeces

# signals callback
func on_diceitem_pressed():
    emit_signal("roll_changed")
    if get_nselected() >= 3:
        disable_unselected()
    else:
        enable_unused()

func on_mouse_entered_diceitem(diceitem):
    var idx = diceitem.get_index()
    emit_signal("mouse_entered_dice", idx)

func on_mouse_exited_diceitem():
    emit_signal("mouse_exited_dice")

func get_nselected():
    var n = 0
    for diceitem in poolcont.get_children():
        n += int(diceitem.selected)
    return n

# private functions
func disable_unselected():
    for diceitem in poolcont.get_children():
        diceitem.disable_unselected()

func enable_unused():
    for diceitem in poolcont.get_children():
        diceitem.enable_unused()
