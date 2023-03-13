extends PanelContainer

# preloads
const RaiseAttackInterface = preload("res://interface/player_gui/dungeon_window/dungeon_gui/attack_menu/attack_ability_interfaces/raise_attack_interface/raise_attack_interface.tscn")

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
signal attack_cmd(cmd)
signal menu_canceled

# public functions
func activate(_pos1, _pos2, attacker, attacked):
    pos1 = _pos1
    pos2 = _pos2
    attack_info.set_summons(attacker, attacker.player, attacked, attacked.player)
    if attacker.has_active_ability("RAISEATTACK"):
        ability_interface = RaiseAttackInterface.instance()
        ability_interface.connect("attack_ability_activated", self, "on_attack_ability_activated")
        ability_interface.set_raise_attack_interface(attacker)
        buttons.add_child_below_node(menu_attack_button, ability_interface)
    visible = true
    transparent_button.pressed = false

func deactivate():
    visible = false
    if is_instance_valid(ability_interface):
        ability_interface.queue_free() 

# signals callbacks
func _on_MenuAttackButton_pressed():
    deactivate()
    emit_signal("attack_cmd", {"name":"ATTACK", "origin":pos1, "dest":pos2})

func on_attack_ability_activated(ability_dict):
    deactivate()
    emit_signal("attack_cmd", {"name":"ATTACK", "origin":pos1, "dest":pos2, "ability":ability_dict})

func _on_MenuCancelButton_pressed():
    deactivate()
    emit_signal("menu_canceled")

func _on_TransparentButton_toggled(button_pressed):
    modulate = Color(1.0, 1.0, 1.0, max(int(!button_pressed), 0.3))
