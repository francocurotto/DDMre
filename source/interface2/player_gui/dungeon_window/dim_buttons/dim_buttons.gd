extends HBoxContainer

# onready variables
onready var net_button = $NetButton
onready var flr_button = $FLRButton
onready var fud_button = $FUDButton
onready var tcw_button = $TCWButton
onready var taw_button = $TAWButton
onready var dim_button = $DimButton
onready var trans_buttons = [net_button, flr_button, fud_button, tcw_button, taw_button]

# signals
signal FLR_button_pressed
signal FUD_button_pressed
signal TCW_button_pressed
signal TAW_button_pressed

# signals callbacks
func on_tile_dim_button_pressed():
    for trans_button in trans_buttons:
        trans_button.disabled = false

func _on_FLRButton_pressed():
    emit_signal("FLR_button_pressed")

func _on_FUDButton_pressed():
    emit_signal("FUD_button_pressed")

func _on_TCWButton_pressed():
    emit_signal("TCW_button_pressed")

func _on_TAWButton_pressed():
    emit_signal("TAW_button_pressed")
