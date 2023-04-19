extends MarginContainer

# onready variables
onready var dungeon_buttons = $DungeonButtons
onready var move_buttons = $MoveButtons
onready var dim_buttons = $DimButtons
onready var select_tile_buttons = $SelectTileButtons
onready var select_direction_buttons = $SelectDirectionButtons

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

func switch_to_move_buttons():
    hide_buttons_guis()
    move_buttons.visible = true

func switch_to_dim_buttons():
    hide_buttons_guis()
    dim_buttons.visible = true

func switch_to_select_tile_buttons(tiles, selected_tile_gui):
    hide_buttons_guis()
    select_tile_buttons.initialize(tiles, selected_tile_gui)
    select_tile_buttons.visible = true

func switch_to_select_direction_buttons(ability):
    hide_buttons_guis()
    select_direction_buttons.initialize(ability)
    select_direction_buttons.visible = true

# signals callbacks
func on_tile_move_button_pressed(pos1, pos2, move_cost):
    switch_to_move_buttons()
    move_buttons.activate(pos1, pos2, move_cost)

# private functions
func hide_buttons_guis():
    for buttons_gui in get_children():
        buttons_gui.visible = false
