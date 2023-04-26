extends Button

var i

signal button_pressed

func _ready():
    connect("pressed", self, "button_pressed")

static func create_button(_parent, _num):
    pass
    #var button = instance() # FAILS

func setup(parent, num):
    i = num
    text = "BUTTON " + str(i)
    connect("button_pressed", parent, "on_button_pressed")
    parent.add_child(self)
    return self

func button_pressed():
    emit_signal("button_pressed", self)
