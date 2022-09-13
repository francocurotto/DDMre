extends PanelContainer

# variables
var on_reply = false

# onready variables
onready var iteminfo = $VBoxContainer/ItemInfo
onready var attackinfo = $VBoxContainer/AttackInfo
onready var replyinfo = $VBoxContainer/ReplyInfo

# signals
signal guard_input
signal wait_input

func _ready():
    replyinfo.connect("guard_input", self, "on_guard_input")
    replyinfo.connect("wait_input", self, "on_wait_input")

# set functions 
func set_player(player):
    iteminfo.set_player(player)

func set_reply(reply_state):
    replyinfo.set_reply(reply_state)

func hide_all():
    iteminfo.visible = false
    attackinfo.visible = false
    replyinfo.visible = false

# signals callback
func on_state_update(state):
    if state == "REPLY":
        on_reply = true
    else:
        on_reply = false

func on_mouse_entered_dice(idx):
    iteminfo.set_dice(idx)
    attackinfo.visible = false
    replyinfo.visible = false
    iteminfo.visible = true

func on_mouse_exited_dice():
    iteminfo.visible = false 
    attackinfo.visible = false
    if on_reply:
        replyinfo.visible = true    

func on_mouse_entered_summon(summon):
    iteminfo.set_summon(summon)
    attackinfo.visible = false
    replyinfo.visible = false
    iteminfo.visible = true

func on_mouse_exited_summon():
    iteminfo.visible = false
    attackinfo.visible = false
    if on_reply:
        replyinfo.visible = true 

func on_mouse_entered_attacked(attaker, attacked):
    attackinfo.set_attack(attaker, attacked)
    iteminfo.visible = false
    replyinfo.visible = false
    attackinfo.visible = true

func on_guard_input():
    replyinfo.visible = false
    emit_signal("guard_input")

func on_wait_input():
    replyinfo.visible = false
    emit_signal("wait_input")   
