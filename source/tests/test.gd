extends GridContainer

func _on_button_mouse_entered():
    print("mouse entered")
    $Label.text = $Label.text + "mouse entered\n"
