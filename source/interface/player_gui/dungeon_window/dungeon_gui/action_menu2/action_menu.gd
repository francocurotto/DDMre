extends PanelContainer

# constants
const AttackGUI = preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/attack_gui/attack_gui.tscn")
const ReplyGUI = preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/reply_gui/reply_gui.tscn")
const StandingAbilityGUI = preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/standing_ability_gui/standing_ability_gui.tscn")

# variables
var action_gui

# onready variables
onready var vbox_menu = $VBoxMenu

# signals
signal check_dungeon_button_pressed
signal attack_button_pressed
signal reply_button_pressed
signal standing_cast_button_pressed
signal cancel_button_pressed
signal highlight_ability_tiles(tiles)
signal ability_select_tile

# public functions
func activate_attack_gui(attacker, attacked):
    action_gui = AttackGUI.instance().setup(self, attacker, attacked)
    vbox_menu.add_child(action_gui)
    visible = true

func activate_reply_gui(attacker, attacked):
    action_gui = ReplyGUI.instance().setup(self, attacker, attacked)
    vbox_menu.add_child(action_gui)
    visible = true

func activate_standing_ability_gui(ability):
    action_gui = StandingAbilityGUI.instance().setup(self, ability)
    vbox_menu.add_child(action_gui)
    visible = true

# signals callbacks
func _on_CheckDungeonButton_pressed():
    emit_signal("check_dungeon_button_pressed")

func on_attack_button_pressed(pos1, pos2, ability_dict):    
    emit_signal("attack_button_pressed", pos1, pos2, ability_dict)
    action_gui.queue_free()
    visible = false

func on_reply_button_pressed(cmd, ability_dict):
    emit_signal("reply_button_pressed", cmd, ability_dict)
    action_gui.queue_free()
    visible = false
    
func on_standing_cast_button_pressed(pos, ability_dict):
    emit_signal("standing_cast_button_pressed", pos, ability_dict)
    action_gui.queue_free()
    visible = false

func on_cancel_button_pressed():
    emit_signal("cancel_button_pressed")
    action_gui.queue_free()
    visible = false

func on_highlight_ability_tiles(tiles):
    emit_signal("highlight_ability_tiles", tiles)

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
