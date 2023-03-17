extends VBoxContainer

# onready variables
onready var dungeon_gui = $DungeonGUI
onready var dungeon_buttons_gui = $DungeonButtonsGUI

# public functions
func reset_to_dungeon():
    dungeon_gui.reset()
    dungeon_buttons_gui.reset()

# signals callbacks
func on_state_update_roll():
    dungeon_gui.reset()
    dungeon_buttons_gui.disable_dungeon_action_buttons()

func on_state_update_dungeon():
    reset_to_dungeon()

func on_state_update_reply(attacker, attacked):
    dungeon_buttons_gui.disable_dungeon_action_buttons()
    dungeon_gui.open_reply_menu(attacker, attacked)
    dungeon_gui.highlight_attack_reply(attacker, attacked)

func on_dice_gui_dim_button_pressed(dice):
    dungeon_gui.on_dice_dim_button_pressed(dice)
    dungeon_buttons_gui.switch_to_dim_buttons()

func on_dice_gui_dim_button_released():
    dungeon_gui.reset()
    dungeon_buttons_gui.switch_to_dungeon_buttons()
