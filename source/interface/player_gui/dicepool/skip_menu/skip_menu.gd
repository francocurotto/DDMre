extends PanelContainer

# signals
signal skipmenu_skip_pressed
signal skipmenu_cancel_pressed

# onready variables
onready var skip_button = $VBoxContainer/ButtonsContainer/SkipButton
onready var cancel_button = $VBoxContainer/ButtonsContainer/CancelButton

func _on_SkipButton_pressed():
    emit_signal("skipmenu_skip_pressed")

func _on_CancelButton_pressed():
    emit_signal("skipmenu_cancel_pressed")
