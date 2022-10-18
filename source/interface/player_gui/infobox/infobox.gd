extends PanelContainer

# preload variables
var DiceInfo = preload("res://interface/player_gui/infobox/dice_info/dice_info.tscn")
var SummonInfo = preload("res://interface/player_gui/infobox/summon_info/summon_info.tscn")

# variables
var player

# onready variables
onready var info_container = $VBoxContainer/InfoContainer

# set functions 
func set_player(_player):
    player = _player

# signals callbacks
func on_mouse_entered_dice(idx):
    InfoGlobals.add_info_node(info_container, DiceInfo, {"dice":player.dicepool[idx]})
   
func on_mouse_entered_summon(summon):
    InfoGlobals.add_info_node(info_container, SummonInfo, {"summon":summon, "player":player})

func on_mouse_exited_dice():
    clear_infobox()

func on_mouse_exited_tile():
    clear_infobox()

# private functions
func clear_infobox():
    for child in info_container.get_children():
        child.queue_free()
