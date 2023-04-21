extends VBoxContainer

# onready variables
onready var dungeon_gui = $DungeonGUI
onready var action_menu = $DungeonGUI/ActionMenu
onready var reply_gui = $DungeonGUI/ActionMenu/VBox/GUIs/ReplyGUI
onready var dungeon_buttons_gui = $DungeonButtonsGUI
onready var dungeon_buttons = $DungeonButtonsGUI/DungeonButtons
onready var select_tile_buttons = $DungeonButtonsGUI/SelectTileButtons

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
    dungeon_gui.activate_reply_gui(attacker, attacked)
    dungeon_gui.highlight_attack_reply(attacker, attacked)

func on_state_update_ability(summon):
    dungeon_buttons_gui.switch_to_dungeon_buttons()
    dungeon_gui.activate_state_ability_gui(summon)

func on_dice_gui_dim_button_pressed(dice):
    dungeon_gui.on_dice_dim_button_pressed(dice)
    dungeon_buttons_gui.switch_to_dim_buttons()

func on_dice_gui_dim_button_released():
    dungeon_gui.reset()
    dungeon_buttons_gui.switch_to_dungeon_buttons()

func on_ability_select_tile(tiles):
    action_menu.visible = false
    dungeon_gui.enable_select_buttons()
    dungeon_gui.on_highlight_ability_tiles(tiles)
    dungeon_gui.connect("tile_select_button_toggled", select_tile_buttons, "on_tile_select_button_toggled")
    dungeon_buttons_gui.switch_to_select_tile_buttons(tiles, dungeon_gui.selected_tile_gui)
    
func on_ability_select_direction(ability):
    action_menu.visible = false
    dungeon_gui.enable_select_buttons()
    dungeon_buttons_gui.switch_to_select_direction_buttons(ability)

func on_select_tile_cancel_button_pressed():
    dungeon_buttons_gui.switch_to_dungeon_buttons()
    dungeon_gui.disconnect("tile_select_button_toggled", select_tile_buttons, "on_tile_select_button_toggled")
    dungeon_gui.on_select_tile_cancel_button_pressed()

func on_select_tile_select_button_pressed():
    dungeon_buttons_gui.switch_to_dungeon_buttons()
    dungeon_gui.disconnect("tile_select_button_toggled", select_tile_buttons, "on_tile_select_button_toggled")
    dungeon_gui.on_select_tile_select_button_pressed()

func on_select_direction_select_button_pressed(direction):
    dungeon_buttons_gui.switch_to_dungeon_buttons()
    dungeon_gui.on_select_direction_select_button_pressed(direction)

func on_ability_ended():
    dungeon_gui.on_ability_ended()
    dungeon_buttons.endturn_button.disabled = false

func on_check_dungeon_button_pressed():
    dungeon_gui.hide_menus()
    dungeon_gui.enable_select_buttons()
    dungeon_buttons.switch_to_back_button()

func on_back_button_pressed():
    dungeon_gui.show_menus()
    dungeon_gui.disable_tile_gui_buttons()
