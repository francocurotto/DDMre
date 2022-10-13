extends PanelContainer

# onready variables
onready var SummonInfo = preload("res://interface/player_gui/infobox/summon_info/summon_info.tscn")

# variables
var summoninfo
var player

func _ready():
    summoninfo = SummonInfo.instance()

# set functions 
func set_player(_player):
    player = _player

# signals callbacks
func on_mouse_entered_dice(idx):
    summoninfo = SummonInfo.instance()
    add_child(summoninfo)
    summoninfo.set_player(player)
    summoninfo.set_dice(idx)

func on_mouse_exited_dice():
    clear_infobox()
   
func on_mouse_entered_summon(summon):
    summoninfo = SummonInfo.instance()
    add_child(summoninfo)
    summoninfo.set_player(player)
    summoninfo.set_summon(summon)

func on_mouse_exited_tile():
    clear_infobox()

# private functions
func clear_infobox():
    for child in get_children():
        child.queue_free()
