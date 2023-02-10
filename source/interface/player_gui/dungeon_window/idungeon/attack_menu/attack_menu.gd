extends PanelContainer

# preloads
const RaiseAttackInterface = preload("res://interface/player_gui/dungeon_window/idungeon/attack_menu/attack_interfaces/raise_attack_interface/raise_attack_interface.tscn")

# variables
var pos1
var pos2
var ability_interface

# onready variables
onready var transparent_button = $VBox/TransparentButton
onready var attack_info = $VBox/AttackInfo
onready var buttons = $VBox/Margins/Buttons
onready var menu_attack_button = $VBox/Margins/Buttons/MenuAttackButton

# singals
signal menu_attack_button_pressed
signal menu_canceled

# public functions
func activate(_pos1, _pos2, attacker, attacked):
    pos1 = _pos1
    pos2 = _pos2
    attack_info.set_summons(attacker, attacker.player, attacked, attacked.player)
    if attacker.has_active_ability("RAISEATTACK"):
        ability_interface = RaiseAttackInterface.instance()
        ability_interface.set_raise_attack_interface(attacker)
        buttons.add_child_below_node(menu_attack_button, ability_interface)
    visible = true
    transparent_button.pressed = false

func deactivate():
    visible = false
    ability_interface.queue_free() 

func _on_MenuAttackButton_pressed():
    deactivate()
    emit_signal("menu_attack_button_pressed", pos1, pos2)

func _on_MenuCancelButton_pressed():
    deactivate()
    emit_signal("menu_canceled")

func _on_TransparentButton_toggled(button_pressed):
    modulate = Color(1.0, 1.0, 1.0, max(int(!button_pressed), 0.3))
