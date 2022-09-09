extends PanelContainer

# variables
var player

# onready variables
onready var infogrid = $InfoBox/InfoGrid
onready var replyinfo = $InfoBox/ReplyInfo

# signals
signal guard_input
signal wait_input

func _ready():
    replyinfo.connect("guard_input", self, "on_guard_input")
    replyinfo.connect("wait_input", self, "on_wait_input")

# set functions 
func set_player(_player):
    pass
    #player = _player

# signals callback
func on_mouse_entered_dice(idx):
    var dice = player.dicepool[idx]
    #set_dice(dice)

func on_mouse_exited_dice():
    pass
    #clear_grid()
    #if replyinfo.enabled:
    #    set_replyinfo_visible()        

func on_mouse_entered_summon(summon):
    pass
    #set_dungobj(summon)

func on_mouse_exited_summon():
    pass
    #clear_grid()
    #if replyinfo.enabled:
    #    set_replyinfo_visible()

func on_guard_input():
    pass
    #turnoff_replyinfo()
    #emit_signal("guard_input")

func on_wait_input():
    pass
    #turnoff_replyinfo()
    #emit_signal("wait_input")   
