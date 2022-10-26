extends PanelContainer

# onready variables
onready var attack_info = $VBoxContainer/AttackInfo
onready var guard_button = $VBoxContainer/ButtonCont/GuardButton
onready var wait_button = $VBoxContainer/ButtonCont/WaitButton

# signals
signal rmenu_guard_pressed
signal rmenu_wait_pressed

# setget functions
func set_reply_menu(reply_state):
    attack_info.set_info({"attacker":reply_state.attacker, "attacked":reply_state.attacked})

# signals callback
func _on_GuardButton_pressed():
    emit_signal("rmenu_guard_pressed")

func _on_WaitButton_pressed():
    emit_signal("rmenu_wait_pressed")

func _input(event):
    if event.is_action_released("ui_cancel"):
        visible = !visible
