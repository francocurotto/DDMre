extends MarginContainer

# variables
var net_button_group = ButtonGroup.new()

# onready variables
onready var main_buttons = $MainButtons
onready var net_button = $MainButtons/NetButton
onready var flr_button = $MainButtons/FLRButton
onready var fud_button = $MainButtons/FUDButton
onready var tcw_button = $MainButtons/TCWButton
onready var taw_button = $MainButtons/TAWButton
onready var dim_button = $MainButtons/DimButton
onready var net_buttons = $NetButtons
onready var x1_button = $NetButtons/X1Button
onready var t1_button = $NetButtons/T1Button
onready var z1_button = $NetButtons/Z1Button
onready var x2_button = $NetButtons/X2Button
onready var t2_button = $NetButtons/T2Button
onready var z2_button = $NetButtons/Z2Button
onready var m1_button = $NetButtons/M1Button
onready var m2_button = $NetButtons/M2Button
onready var s1_button = $NetButtons/S1Button
onready var s2_button = $NetButtons/S2Button
onready var l1_button = $NetButtons/L1Button
onready var trans_buttons = [net_button, flr_button, fud_button, tcw_button, taw_button]
onready var net_select_buttons = [x1_button, t1_button, z1_button, x2_button, t2_button, z2_button,
    m1_button, m2_button, s1_button, s2_button, l1_button]

# signals
signal net_button_pressed
signal FLR_button_pressed
signal FUD_button_pressed
signal TCW_button_pressed
signal TAW_button_pressed
signal net_select_button_pressed(net_index)
signal dim_button_pressed

func _ready():
    net_button_group.connect("pressed", self, "on_net_button_pressed")
    for net_select_button in net_select_buttons:
        net_select_button.group = net_button_group

# public functions
func disable_buttons():
    for main_button in main_buttons.get_children():
        main_button.disabled = true

func enable_trans_buttons():
    for button in trans_buttons:
       button.disabled = false

# signals callbacks
func on_net_updated(can_dimension):
    enable_trans_buttons()
    dim_button.disabled = not can_dimension

func _on_NetButton_pressed():
    main_buttons.visible = false
    net_buttons.visible = true

func _on_FLRButton_pressed():
    emit_signal("FLR_button_pressed")

func _on_FUDButton_pressed():
    emit_signal("FUD_button_pressed")

func _on_TCWButton_pressed():
    emit_signal("TCW_button_pressed")

func _on_TAWButton_pressed():
    emit_signal("TAW_button_pressed")

func _on_DimButton_pressed():
    emit_signal("dim_button_pressed")

func on_net_button_pressed(button):
    var net_index = net_select_buttons.find(button)
    net_button.icon = button.icon
    emit_signal("net_select_button_pressed", net_index)

func _on_CancelButton_pressed():
    main_buttons.visible = true
    net_buttons.visible = false
