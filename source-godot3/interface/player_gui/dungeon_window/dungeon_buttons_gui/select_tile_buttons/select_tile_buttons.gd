extends HBoxContainer

# variables
var tiles

# onready variables
onready var select_button = $SelectButton

# signals
signal select_tile_select_button_pressed
signal select_tile_cancel_button_pressed

# public functions
func initialize(_tiles, selected_tile_gui):
    tiles = _tiles
    if selected_tile_gui != null:
        on_tile_select_button_toggled(selected_tile_gui.tile, true)

# signals callbacks
func on_tile_select_button_toggled(tile, pressed):
    select_button.disabled = not(pressed and tile in tiles)

func _on_CancelButton_pressed():
    emit_signal("select_tile_cancel_button_pressed")

func _on_SelectButton_pressed():
    emit_signal("select_tile_select_button_pressed")
