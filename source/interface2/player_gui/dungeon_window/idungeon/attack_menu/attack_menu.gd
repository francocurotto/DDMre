extends PanelContainer

# variables
var pos1
var pos2

# onready variables
onready var attack_info = $VBox/AttackInfo
onready var menu_attack_button = $VBox/Margins/Buttons/MenuAttackButton
onready var menu_cancel_button = $VBox/Margins/Buttons/MenuCancelButton

# singals
signal menu_attack_button_pressed
signal menu_canceled

# public functions
func activate(_pos1, _pos2, attacker, attacked):
    pos1 = _pos1
    pos2 = _pos2
    attack_info.set_summons(attacker, attacker.player, attacked, attacked.player)
    visible = true

func _on_MenuAttackButton_pressed():
    visible = false
    emit_signal("menu_attack_button_pressed", pos1, pos2)

func _on_MenuCancelButton_pressed():
    visible = false
    emit_signal("menu_canceled")
