extends MarginContainer

# signals
signal sort_button_pressed

func _ready():
    for button in $HBox.get_children():
        button.pressed.connect(func(): sort_button_pressed.emit())
        
