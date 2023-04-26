extends PanelContainer

# constants
const AttackGUI = preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/attack_gui/attack_gui.tscn")
const ReplyGUI = 0
const AbilityGUI = 0

# variables
var action_gui

# signals
signal check_dungeon_button_pressed
signal attack_button_pressed

# public functions
func activate_attack_gui(attacker, attacked):
    action_gui = AttackGUI.instance().setup(self, attacker, attacked)
    visible = true

#func activate_reply_gui(attacker, attacked):
#    action_gui = ReplyGUI.instance().setup(self, attacker, attacked)
#    visible = true
#
#func activate_ability_gui(tile):
#    action_gui = ReplyGUI.instance().setup(self, attacker, attacked)
#    visible = true

# signals callbacks
func _on_CheckDungeonButton_pressed():
    emit_signal("check_dungeon_button_pressed")

func on_attack_button_pressed(pos1, pos2, activate_dict):    
    emit_signal("attack_button_pressed", pos1, pos2, activate_dict)
    action_gui.queue_free()
    visible = false

func on_cancel_button_pressed():
    emit_signal("cancel_button_pressed")
    action_gui.queue_free()
    visible = false

func on_select_tile_cancel_button_pressed():
    self.active_gui.on_select_tile_cancel_button_pressed()
    visible = true
    
func on_select_tile_select_button_pressed(tile):
    self.active_gui.on_select_tile_select_button_pressed(tile)
    visible = true

func on_select_direction_select_button_pressed(direction):
    self.active_gui.on_select_direction_select_button_pressed(direction)
    visible = true
