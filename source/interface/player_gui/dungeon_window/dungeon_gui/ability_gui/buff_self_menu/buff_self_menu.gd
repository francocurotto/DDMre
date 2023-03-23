extends PanelContainer

# public functions
func set_menu(_monster):
    pass

func _on_TransparentButton_toggled(button_pressed):
    modulate = Color(1.0, 1.0, 1.0, max(int(!button_pressed), 0.3))
