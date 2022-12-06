extends HBoxContainer

# onready variables
onready var net_button = $NetButton
onready var flr_button = $FLRButton
onready var fud_button = $FUDButton
onready var tcw_button = $TCWButton
onready var taw_button = $TAWButton
onready var dim_button = $DimButton
onready var trans_buttons = [net_button, flr_button, fud_button, tcw_button, taw_button]
onready var buttons = trans_buttons.duplicate() + [dim_button]

# signals
signal net_button_pressed
signal FLR_button_pressed
signal FUD_button_pressed
signal TCW_button_pressed
signal TAW_button_pressed
signal dim_button_pressed

# public functions
func disable_buttons():
    for button in buttons:
        button.disabled = true

func enable_trans_buttons():
    for button in trans_buttons:
        button.disabled = false

# signals callbacks
func on_net_updated(can_dimension):
    enable_trans_buttons()
    dim_button.disabled = not can_dimension

func _on_NetButton_pressed():
    disable_buttons()
    emit_signal("net_button_pressed")

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
