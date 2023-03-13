extends VBoxContainer

# onready variables
onready var dungeon_gui = $DungeonGUI
onready var dungeon_buttons = $DungeonButtons
onready var dim_buttons = $DimButtons

# public functions
func reset_to_dungeon():
    dungeon_gui.reset()
    dungeon_buttons.switch_to_action_buttons()
    dungeon_buttons.endturn_button.disabled = false
    dungeon_buttons.cancel_button.disabled = false
    dim_buttons.disable_buttons()
    switch_to_dungeon_buttons()

# signals callbacks
func on_state_update_roll():
    dungeon_gui.reset()
    dungeon_buttons.disable_action_buttons()

func on_state_update_dungeon():
    reset_to_dungeon()

func on_state_update_reply(attacker, attacked):
    dungeon_buttons.disable_action_buttons()
    dungeon_gui.open_reply_menu(attacker, attacked)
    dungeon_gui.highlight_attack_reply(attacker, attacked)

func on_dice_gui_dim_button_pressed(dice):
    dungeon_gui.on_dice_dim_button_pressed(dice)
    switch_to_dim_buttons()

func on_dice_gui_dim_button_released():
    dungeon_gui.reset()
    switch_to_dungeon_buttons()

# private functions
func switch_to_dim_buttons():
    dim_buttons.visible = true
    dungeon_buttons.visible = false

func switch_to_dungeon_buttons():
    dungeon_buttons.visible = true
    dim_buttons.visible = false
