extends VBoxContainer

# constants
const RaiseAttackGUI = preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/attack_gui/raise_attack_gui/raise_attack_gui.tscn")

# variables
var pos1
var pos2
var attack_ability_gui

# onready variables
onready var attack_info = $AttackInfo
onready var attack_button = $Margins/Controls/AttackButton

# singals
signal attack_button_pressed(pos1, pos2, activate_dict)
signal cancel_button_pressed

# public functions
func setup(action_menu, attacker, attacked):
    pos1 = attacker.tile.pos
    pos2 = attacked.tile.pos
    attack_info.set_summons(attacker, attacker.player, attacked, attacked.player)
    if attacker.has_active_ability("RAISEATTACK"): # TODO: add case ability negated
        RaiseAttackGUI.instance().setup(self, attacker)
    connect("attack_button_pressed", action_menu, "on_attack_button_pressed")
    connect("cancel_button_pressed", action_menu, "on_cancel_button_pressed")
    action_menu.add_child(self)
    return self

# signals callbacks
func _on_AttackButton_pressed():
    emit_signal("attack_button_pressed", pos1, pos2)

func _on_CancelButton_pressed():
    emit_signal("cancel_button_canceled")

func on_attack_ability_activated(ability_dict):
    emit_signal("attack_button_pressed", pos1, pos2, ability_dict)
