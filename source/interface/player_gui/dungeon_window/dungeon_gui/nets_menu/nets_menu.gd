extends PanelContainer

# variables
var button_group = ButtonGroup.new()

# onready variables
onready var x1_button = $Grid/X1Button
onready var t1_button = $Grid/T1Button
onready var z1_button = $Grid/Z1Button
onready var x2_button = $Grid/X2Button
onready var t2_button = $Grid/T2Button
onready var z2_button = $Grid/Z2Button
onready var m1_button = $Grid/M1Button
onready var m2_button = $Grid/M2Button
onready var s1_button = $Grid/S1Button
onready var s2_button = $Grid/S2Button
onready var l1_button = $Grid/L1Button
onready var buttons = [x1_button, t1_button, z1_button, x2_button, t2_button, z2_button,
    m1_button, m2_button, s1_button, s2_button, l1_button]
onready var transparent_button = $Grid/TransparentButton

# signals
signal net_select_button_pressed(net_index)

func _ready():
    button_group.connect("pressed", self, "on_button_pressed")
    for button in buttons:
        button.group = button_group

func activate():
    visible = true
    transparent_button.pressed = false

# signals callbacks
func on_button_pressed(button):
    var net_index = buttons.find(button)
    visible = false
    emit_signal("net_select_button_pressed", net_index)

func _on_TransparentButton_toggled(button_pressed):
    modulate = Color(1.0, 1.0, 1.0, max(int(!button_pressed), 0.3))
