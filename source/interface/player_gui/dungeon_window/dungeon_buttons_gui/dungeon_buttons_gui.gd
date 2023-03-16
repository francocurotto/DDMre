extends MarginContainer

# onready variables
onready var dungeon_buttons = $DungeonButtons
onready var dim_buttons = $DimButtons
onready var ability_buttons_gui = $AbilityButtonsGUI

# public functions
func reset():
    dungeon_buttons.switch_to_action_buttons()
    dungeon_buttons.endturn_button.disabled = false
    dungeon_buttons.cancel_button.disabled = false
    dim_buttons.disable_buttons()
    switch_to_dungeon_buttons()

func disable_dungeon_action_buttons():
    dungeon_buttons.disable_action_buttons()

func switch_to_dungeon_buttons():
    hide_buttons_guis()
    dungeon_buttons.visible = true

func switch_to_dim_buttons():
    hide_buttons_guis()
    dim_buttons.visible = true

func switch_to_ability_buttons_gui():
    hide_buttons_guis()
    ability_buttons_gui.visible = true

# private functions
func hide_buttons_guis():
    for buttons_gui in get_children():
        buttons_gui.visible = false
