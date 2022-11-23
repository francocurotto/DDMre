extends VBoxContainer

signal window_button_pressed

# singal callback
func _on_WindowButton_pressed():
    emit_signal("window_button_pressed")
