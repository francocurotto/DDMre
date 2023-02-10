extends PanelContainer

# onready variables
onready var attack_info = $VBox/AttackInfo
onready var transparent_button = $VBox/TransparentButton

# singals
signal menu_guard_button_pressed
signal menu_wait_button_pressed

# public functions
func activate(attacker, attacked):
    attack_info.set_summons(attacker, attacker.player, attacked, attacked.player)
    visible = true
    transparent_button.pressed = false

func _on_MenuGuardButton_pressed():
    visible = false
    emit_signal("menu_guard_button_pressed")

func _on_MenuWaitButton_pressed():
    visible = false
    emit_signal("menu_wait_button_pressed")

func _on_TransparentButton_toggled(button_pressed):
    modulate = Color(1.0, 1.0, 1.0, max(int(!button_pressed), 0.3))
