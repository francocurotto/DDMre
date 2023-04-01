extends PanelContainer

# variables
var pos1
var pos2

# onready variables
onready var attack_info = $VBox/AttackInfo
onready var buttons = $VBox/Margins/Buttons
onready var menu_attack_button = $VBox/Margins/Buttons/MenuAttackButton
onready var raise_attack_gui = $VBox/Margins/Buttons/RaiseAttackGUI

# singals
signal attack_cmd(cmd)
signal menu_canceled
signal check_dungeon_button_pressed

func _ready():
    raise_attack_gui.connect("attack_ability_activated", self, "on_attack_ability_activated")

# public functions
func activate(_pos1, _pos2, attacker, attacked):
    pos1 = _pos1
    pos2 = _pos2
    attack_info.set_summons(attacker, attacker.player, attacked, attacked.player)
    if attacker.has_active_ability("RAISEATTACK"): # TODO: add case ability negated
        raise_attack_gui.set_raise_attack_interface(attacker)
    visible = true

func deactivate():
    raise_attack_gui.visible = false
    visible = false

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

func _on_CheckDungeonButton_pressed():
    emit_signal("check_dungeon_button_pressed")
