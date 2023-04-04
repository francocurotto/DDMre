extends HBoxContainer

# variables
var tiles

# onready variables
onready var select_button = $SelectButton

# signals
signal select_tile_select_button_pressed
signal select_tile_cancel_button_pressed

# public functions
func initialize(_tiles):
    tiles = _tiles
    select_button.disabled = true
    visible = true

# signals callbacks
func on_tile_select_button_toggled(tile, pressed):
    select_button.disabled = not(pressed and tile in tiles)

func _on_CancelButton_pressed():
    emit_signal("reply_ability_select_monster_cancel_button_pressed")

func _on_SelectButton_pressed():
    emit_signal("reply_ability_select_monster_select_button_pressed")
