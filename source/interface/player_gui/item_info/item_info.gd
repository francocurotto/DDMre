extends PanelContainer

# export variables
export(PackedScene) var SideItem

# variables
var player

# onready variables
onready var infogrid = $InfoBox/InfoGrid
onready var replyinfo = $InfoBox/ReplyInfo

# signals
signal guard_input
signal wait_input

func _ready():
    clear_grid()
    replyinfo.connect("guard_input", self, "on_guard_input")
    replyinfo.connect("wait_input", self, "on_wait_input")

# set functions 
func set_player(_player):
    player = _player

func set_dice(dice):
    clear_grid()
    add_text("NAME:", dice.card.name)
    add_text("TYPE:", dice.card.type)
    add_text("LEVEL:", str(dice.card.level))
    if dice.card.is_monster():
        add_text("ATTACK:", str(dice.card.attack))
        add_text("DEFENSE:", str(dice.card.defense))
        add_text("HEALTH:", str(dice.card.health))
    add_sides(dice.sides)

func set_dungobj(dungobj):
    clear_grid()
    if not dungobj.is_summon():
        return
    add_text("NAME:", dungobj.card.name)
    add_text("TYPE:", dungobj.card.type)
    add_text("LEVEL:", str(dungobj.card.level))
    if dungobj.is_monster():
        add_text("ATTACK:", str(dungobj.card.attack)+"/"+str(dungobj.attack))
        add_text("DEFENSE:", str(dungobj.card.defense)+"/"+str(dungobj.defense))
        add_text("HEALTH:", str(dungobj.card.health)+"/"+str(dungobj.health))

func clear_grid():
    replyinfo.visible = false
    for child in infogrid.get_children():
        infogrid.remove_child(child)
        child.queue_free()

func enable_replyinfo():
    replyinfo.enabled = true

func set_replyinfo_visible():
    replyinfo.visible = true

func turnoff_replyinfo():
    replyinfo.enabled = false
    clear_grid()

# signals callback
func on_mouse_entered_dice(idx):
    var dice = player.dicepool[idx]
    set_dice(dice)

func on_mouse_exited_dice():
    clear_grid()
    if replyinfo.enabled:
        set_replyinfo_visible()        

func on_mouse_entered_summon(summon):
    set_dungobj(summon)

func on_mouse_exited_summon():
    clear_grid()
    if replyinfo.enabled:
        set_replyinfo_visible()

func on_guard_input():
    turnoff_replyinfo()
    emit_signal("guard_input")

func on_wait_input():
    turnoff_replyinfo()
    emit_signal("wait_input")   

# private functions
func add_text(str1, str2):
    var label1 = Label.new()
    var label2 = Label.new()
    label1.text = str1
    label2.text = str2
    infogrid.add_child(label1)
    infogrid.add_child(label2)

func add_sides(sides):
    var label = Label.new()
    label.text = "DICE:"
    var sidesbox = HBoxContainer.new()
    for side in sides:
        var sideitem = SideItem.instance()
        sideitem.set_side(side)
        sidesbox.add_child(sideitem)
    infogrid.add_child(label)
    infogrid.add_child(sidesbox)
