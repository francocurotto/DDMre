extends Button

func _ready():
    print("test")
    print_func()

func print_func():
    print("print_func_test")

func _on_Button_pressed():
    print("Button pressed")
