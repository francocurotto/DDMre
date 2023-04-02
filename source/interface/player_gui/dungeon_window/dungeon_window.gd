extends VBoxContainer

# onready variables
onready var dungeon_gui = $DungeonGUI
onready var reply_gui = $DungeonGUI/ActionMenu/VBox/GUIs/ReplyGUI
onready var dungeon_buttons_gui = $DungeonButtonsGUI
onready var dungeon_buttons = $DungeonButtonsGUI/DungeonButtons
onready var ability_buttons_gui = $DungeonButtonsGUI/AbilityButtonsGUI

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

func on_reply_ability_select_monster(monsters):
    dungeon_gui.enable_select_buttons()
    dungeon_gui.connect("tile_select_button_toggled", ability_buttons_gui, "on_tile_select_button_toggled")
    dungeon_buttons_gui.switch_to_ability_buttons_gui()
    ability_buttons_gui.switch_to_reply_select_monster_buttons(monsters)
    reply_gui.visible = false

func on_reply_ability_select_monster_cancel_button_pressed():
    dungeon_buttons_gui.switch_to_dungeon_buttons()
    dungeon_gui.disconnect("tile_select_button_toggled", ability_buttons_gui, "on_tile_select_button_toggled")
    dungeon_gui.on_reply_ability_select_monster_cancel_button_pressed()

func on_reply_ability_select_monster_select_button_pressed():
    dungeon_buttons_gui.switch_to_dungeon_buttons()
    dungeon_gui.disconnect("tile_select_button_toggled", ability_buttons_gui, "on_tile_select_button_toggled")
    dungeon_gui.on_reply_ability_select_monster_select_button_pressed()

func on_standing_ability_ended():
    dungeon_gui.on_standing_ability_ended()
    dungeon_buttons.endturn_button.disabled = false

func on_check_dungeon_button_pressed():
    dungeon_gui.hide_menus()
    dungeon_gui.enable_select_buttons()
    dungeon_buttons.switch_to_back_button()

func on_back_button_pressed():
    dungeon_gui.show_menus()
    dungeon_gui.unset_highlights()
    dungeon_gui.disable_tile_gui_buttons()
    dungeon_gui.diselect_tile_gui()
