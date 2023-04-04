extends MarginContainer

# variables
var active_gui

# onready variables
onready var select_tile_buttons = $SelectTileButtons

# signals
signal select_tile_cancel_button_pressed
signal select_tile_select_button_pressed

func _ready():
    select_tile_buttons.connect("select_tile_cancel_button_pressed", self, "on_select_tile_cancel_button_pressed")
    select_tile_buttons.connect("select_tile_select_button_pressed", self, "on_select_tile_select_button_pressed")

# public functions
func switch_to_select_tile_buttons(tiles):
    hide_buttons_guis()
    select_tile_buttons.initialize(tiles)
    active_gui = select_tile_buttons

# signals callbacks
func on_tile_select_button_toggled(content, pressed):
    active_gui.on_tile_select_button_toggled(content, pressed)

func on_select_tile_cancel_button_pressed():
    emit_signal("select_tile_cancel_button_pressed")

func on_select_tile_select_button_pressed():
    emit_signal("select_tile_select_button_pressed")

# private functions
func hide_buttons_guis():
    for buttons_gui in get_children():
        buttons_gui.visible = false
