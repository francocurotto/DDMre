extends Button

# variables
var card

# signals
signal info_button_pressed(card)

# setget functions
func set_card(_card):
    card = _card

# singals callback
func _on_Button_pressed():
    emit_signal("info_button_pressed", card)
