extends PanelContainer

# onready variables
onready var attack_info = $VBox/AttackInfo

# singals
signal menu_guard_button_pressed
signal menu_wait_button_pressed

# public functions
func activate(attacker, attacked):
    attack_info.set_summons(attacker, attacker.player, attacked, attacked.player)
    visible = true

func _on_MenuGuardButton_pressed():
    visible = false
    emit_signal("menu_guard_button_pressed")

func _on_MenuWaitButton_pressed():
    visible = false
    emit_signal("menu_wait_button_pressed")
