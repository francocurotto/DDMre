extends PanelContainer

signal dmenu_cancel_pressed

# setget functions
func enable():
    visible = true

func disable():
    visible = false

# signal callbacks
func _on_CancelButton_pressed():
    emit_signal("dmenu_cancel_pressed")
