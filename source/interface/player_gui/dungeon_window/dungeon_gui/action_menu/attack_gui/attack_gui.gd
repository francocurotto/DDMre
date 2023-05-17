extends VBoxContainer

# constants
const RaiseAttackGUI = preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/attack_gui/raise_attack_gui/raise_attack_gui.tscn")

# variables
var attacker
var attacked

# onready variables
onready var attack_info = $AttackInfo
onready var controls = $Margins/Controls
onready var attack_button = $Margins/Controls/AttackButton

# singals
signal attack_button_pressed(pos1, pos2, activate_dict)
signal cancel_button_pressed

func _ready():
    attack_info.set_summons(attacker, attacker.player, attacked, attacked.player)
    if attacker.has_active_ability("RAISEATTACK"): # TODO: add case ability negated
        var raise_attack_gui = RaiseAttackGUI.instance().setup(self, attacker)
        controls.add_child_below_node(attack_button, raise_attack_gui)

# public functions
func setup(action_menu, _attacker, _attacked):
    attacker = _attacker
    attacked = _attacked
    connect("attack_button_pressed", action_menu, "on_attack_button_pressed")
    connect("cancel_button_pressed", action_menu, "on_cancel_button_pressed")
    return self

# signals callbacks
func _on_AttackButton_pressed():
    emit_signal("attack_button_pressed", attacker.tile.pos, attacked.tile.pos, null)

func _on_CancelButton_pressed():
    emit_signal("cancel_button_pressed")

func on_attack_ability_activated(ability_dict):
    emit_signal("attack_button_pressed", attacker.tile.pos, attacked.tile.pos, ability_dict)
