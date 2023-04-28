extends PanelContainer

# constants
const AttackGUI = preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/attack_gui/attack_gui.tscn")
const ReplyGUI = preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/reply_gui/reply_gui.tscn")
const AbilityGUI = 0

# variables
var action_gui

# signals
signal check_dungeon_button_pressed
signal attack_button_pressed
signal cancel_button_pressed
signal reply_button_pressed
signal ability_select_tile

# public functions
func activate_attack_gui(attacker, attacked):
    action_gui = AttackGUI.instance().setup(self, attacker, attacked)
    visible = true

func activate_reply_gui(attacker, attacked):
    action_gui = ReplyGUI.instance().setup(self, attacker, attacked)
    add_child(action_gui)
    visible = true

#func activate_ability_gui(tile):
#    action_gui = ReplyGUI.instance().setup(self, attacker, attacked)
#    visible = true

# signals callbacks
func _on_CheckDungeonButton_pressed():
    emit_signal("check_dungeon_button_pressed")

func on_attack_button_pressed(pos1, pos2, ability_dict):    
    emit_signal("attack_button_pressed", pos1, pos2, ability_dict)
    action_gui.queue_free()
    visible = false

func on_cancel_button_pressed():
    emit_signal("cancel_button_pressed")
    action_gui.queue_free()
    visible = false

func on_reply_button_pressed(cmd, ability_dict):
    emit_signal("reply_button_pressed", cmd, ability_dict)
    action_gui.queue_free()
    visible = false

func on_ability_select_tile(tiles):
    emit_signal("ability_select_tile", tiles)
    visible = false

func on_select_tile_cancel_button_pressed():
    action_gui.on_select_tile_cancel_button_pressed()
    visible = true
    
func on_select_tile_select_button_pressed(tile):
    action_gui.on_select_tile_select_button_pressed(tile)
    visible = true

func on_select_direction_select_button_pressed(direction):
    action_gui.on_select_direction_select_button_pressed(direction)
    visible = true
