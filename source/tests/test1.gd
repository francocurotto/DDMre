extends VBoxContainer

const MyButton = preload("res://tests/test2.tscn")

func _ready():
    for i in range(3):
        create_button(i)

func on_button_pressed(button):
    print("signal_worked, button " + str(button.i) + " pressed")

func create_button(i):
    var button = MyButton.instance().setup(self, i)
    print("Button " + str(button) + " created")
