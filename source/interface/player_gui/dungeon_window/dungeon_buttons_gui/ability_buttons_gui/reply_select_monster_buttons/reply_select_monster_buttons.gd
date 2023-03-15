extends HBoxContainer

# variables
var monsters

# onready variables
onready var select_reply_ability_button = $SelectReplyAbilityButton

# signals
signal cancel_reply_ability_button_pressed
signal select_reply_ability_button_pressed

# public functions
func initialize(_monsters):
    monsters = _monsters
    select_reply_ability_button.disabled = true
    visible = true

# signals callbacks
func on_tile_select_button_toggled(content, pressed):
    select_reply_ability_button.disabled = not(pressed and content in monsters)

func _on_CancelReplyAbilityButton_pressed():
    emit_signal("cancel_reply_ability_button_pressed")

func _on_SelectReplyAbilityButton_pressed():
    emit_signal("select_reply_ability_button_pressed")
