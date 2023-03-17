extends HBoxContainer

# variables
var monsters

# onready variables
onready var select_button = $SelectButton

# signals
signal reply_ability_select_monster_select_button_pressed
signal reply_ability_select_monster_cancel_button_pressed

# public functions
func initialize(_monsters):
    monsters = _monsters
    select_button.disabled = true
    visible = true

# signals callbacks
func on_tile_select_button_toggled(content, pressed):
    select_button.disabled = not(pressed and content in monsters)

func _on_CancelButton_pressed():
    emit_signal("reply_ability_select_monster_cancel_button_pressed")

func _on_SelectButton_pressed():
    emit_signal("reply_ability_select_monster_select_button_pressed")
