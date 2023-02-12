extends Button

# variables
var raise

# signals
signal raise_attack_button_pressed(raise)

# setget functions
func set_raise_attack_button(attack, _raise):
    raise = _raise
    text = "⚔ATTACK %d (%d⚔)" % [attack + 10*raise, raise+1] 

# signals callbacks
func _on_RaiseAttackButton_pressed():
    emit_signal("raise_attack_button_pressed", raise)
