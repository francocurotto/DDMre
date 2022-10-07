extends PanelContainer

# onready variables
onready var attacker_info = $VBoxContainer/AttackerInfo
onready var attacked_info = $VBoxContainer/AttackedInfo
onready var guard_button = $VBoxContainer/ButtonCont/GuardButton
onready var wait_button = $VBoxContainer/ButtonCont/WaitButton

# signals
signal rmenu_guard_pressed
signal rmenu_wait_pressed

# setget functions
func set_reply_menu(reply_state):
    attacker_info.set_player(reply_state.opponent)
    attacker_info.set_summon(reply_state.attacker)
    attacked_info.set_player(reply_state.player)
    attacked_info.set_summon(reply_state.attacked)
    
# signals callback
func _on_GuardButton_pressed():
    emit_signal("rmenu_guard_pressed")

func _on_WaitButton_pressed():
    emit_signal("rmenu_wait_pressed")

func _input(event):
    if event.is_action_released("ui_cancel"):
        visible = !visible
