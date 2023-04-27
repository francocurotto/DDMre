extends Button

# variables
var raise

# signals
signal raise_attack_button_pressed(raise)

# setget functions
func setup(raise_attack_gui, monster, _raise):
    raise = _raise
    text = "⚔ATTACK +%d (%d⚔)" % [10*raise, raise+1]
    if monster.player.crestpool.slots["ATTACK"] < raise+1:
        disabled = true 
    connect("raise_attack_button_pressed", raise_attack_gui, "on_raise_attack_button_pressed")
    return self

# signals callbacks
func _on_RaiseAttackButton_pressed():
    emit_signal("raise_attack_button_pressed", raise)
