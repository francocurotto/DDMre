extends PanelContainer

# variables
var pos1
var pos2

# onready variables
onready var attack_info = $VBox/AttackInfo
onready var transparent_button = $VBox/Margins/Buttons/TransparentButton

# singals
signal menu_attack_button_pressed
signal menu_canceled

# public functions
func activate(_pos1, _pos2, attacker, attacked):
    pos1 = _pos1
    pos2 = _pos2
    attack_info.set_summons(attacker, attacker.player, attacked, attacked.player)
    visible = true
    transparent_button.pressed = false

func _on_MenuAttackButton_pressed():
    visible = false
    emit_signal("menu_attack_button_pressed", pos1, pos2)

func _on_MenuCancelButton_pressed():
    visible = false
    emit_signal("menu_canceled")

func _on_TransparentButton_toggled(button_pressed):
    modulate = Color(1.0, 1.0, 1.0, max(int(!button_pressed), 0.3))
