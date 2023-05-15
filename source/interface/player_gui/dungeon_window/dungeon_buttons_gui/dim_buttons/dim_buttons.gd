extends MarginContainer

# onready variables
onready var main_buttons = $MainButtons
onready var net_prev_button = $MainButtons/NetPrevButton
onready var net_next_button = $MainButtons/NetNextButton
onready var tcw_button = $MainButtons/TCWButton
onready var taw_button = $MainButtons/TAWButton
onready var dim_button = $MainButtons/DimButton
onready var trans_buttons = [net_prev_button, net_next_button, tcw_button, taw_button]

# signals
signal net_button_pressed(adder)
signal TCW_button_pressed
signal TAW_button_pressed
signal dim_button_pressed

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

func _on_NetPrevButton_pressed():
    emit_signal("net_button_pressed", -1)

func _on_NetNextButton_pressed():
    emit_signal("net_button_pressed", 1)

func _on_TCWButton_pressed():
    emit_signal("TCW_button_pressed")

func _on_TAWButton_pressed():
    emit_signal("TAW_button_pressed")

func _on_DimButton_pressed():
    emit_signal("dim_button_pressed")
