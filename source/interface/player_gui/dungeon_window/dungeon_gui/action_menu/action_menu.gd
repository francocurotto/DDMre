extends PanelContainer

# variables
var active_gui setget , get_active_gui

# onready variables
onready var guis = $VBox/GUIs
onready var attack_gui = $VBox/GUIs/AttackGUI
onready var reply_gui = $VBox/GUIs/ReplyGUI

# signals
signal check_dungeon_button_pressed
signal ability_select_tile(poss)

# setget functions
func get_active_gui():
    for gui in guis:
        if gui.visible:
            return gui

# public functions
func activate_attack_gui(attacker, attacked):
    attack_gui.activate(attacker, attacked)
    visible = true

func activate_reply_gui(attacker, attacked):
    reply_gui.activate(attacker, attacked)
    visible = true

# signals callbacks
func _on_CheckDungeonButton_pressed():
    emit_signal("check_dungeon_button_pressed")

func on_ability_select_tile(tiles):
    emit_signal("ability_select_tile", tiles)
    visible = false

func on_select_tile_cancel_button_pressed():
    active_gui.on_select_tile_cancel_button_pressed()
    visible = true
    
func on_select_tile_select_button_pressed(tile):
    active_gui.on_select_tile_select_button_pressed(tile)
    visible = true
