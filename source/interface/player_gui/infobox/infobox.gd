extends PanelContainer

# variables
var on_reply = false

# onready variables
onready var diceinfo = $VBoxContainer/DiceInfo
onready var summoninfo = $VBoxContainer/SummonInfo

func _ready():
    hide_all()

# set functions 
func set_player(player):
    diceinfo.set_player(player)
    summoninfo.set_player(player)

func hide_all():
    diceinfo.visible = false
    summoninfo.visible = false

func on_mouse_entered_dice(idx):
    diceinfo.set_dice(idx)
    diceinfo.visible = true
    summoninfo.visible = false

func on_mouse_exited_dice():
    diceinfo.visible = false 
   
func on_mouse_entered_summon(summon):
    summoninfo.set_summon(summon)
    diceinfo.visible = false
    summoninfo.visible = true

func on_mouse_exited_tile():
    summoninfo.visible = false
