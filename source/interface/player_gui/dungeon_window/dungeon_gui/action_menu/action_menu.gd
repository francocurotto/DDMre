extends PanelContainer

# variables
var active_gui setget , get_active_gui

# onready variables
onready var guis = $VBox/GUIs
onready var attack_gui = $VBox/GUIs/AttackGUI
onready var reply_gui = $VBox/GUIs/ReplyGUI
onready var standing_ability_gui = $VBox/GUIs/StandingAbilityGUI
onready var state_ability_gui = $VBox/GUIs/StateAbilityGUI

# signals
signal check_dungeon_button_pressed
#signal ability_select_tile(poss)

# setget functions
func get_active_gui():
    for gui in guis.get_children():
        if gui.visible:
            return gui

# public functions
func activate_attack_gui(attacker, attacked):
    attack_gui.activate(attacker, attacked)
    visible = true

func activate_reply_gui(attacker, attacked):
    reply_gui.activate(attacker, attacked)
    visible = true

func activate_ability_gui(tile):
    standing_ability_gui.activate(tile)
    visible = true

func activate_state_ability_gui(summon):
    state_ability_gui.activate(summon)
    visible = true

# signals callbacks
func _on_CheckDungeonButton_pressed():
    emit_signal("check_dungeon_button_pressed")

func on_select_tile_cancel_button_pressed():
    self.active_gui.on_select_tile_cancel_button_pressed()
    visible = true
    
func on_select_tile_select_button_pressed(tile):
    self.active_gui.on_select_tile_select_button_pressed(tile)
    visible = true

func on_select_direction_select_button_pressed(direction):
    self.active_gui.on_select_direction_select_button_pressed(direction)
    visible = true
