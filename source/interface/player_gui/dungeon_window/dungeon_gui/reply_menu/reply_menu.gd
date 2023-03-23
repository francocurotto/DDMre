extends PanelContainer

# variables
var attacked

# onready variables
onready var attack_info = $VBox/AttackInfo
onready var transparent_button = $VBox/TransparentButton
onready var menu_guard_button = $VBox/Margins/GUIVBox/MenuGuardButton
onready var reply_ability_gui = $VBox/Margins/GUIVBox/ReplyAbilityGUI

# singals
signal reply_cmd(cmd)

# public functions
func activate(_attacker, _attacked):
    attacked = _attacked
    attack_info.set_summons(_attacker, _attacker.player, attacked, attacked.player)
    menu_guard_button.disabled = attacked.player.crestpool.slots["DEFENSE"] < 1
    reply_ability_gui.activate(attacked)
    transparent_button.pressed = false
    visible = true

func deactivate():
    visible = false
    menu_guard_button.disabled = false
    reply_ability_gui.deactivate()

# signals callbacks
func _on_MenuGuardButton_pressed():
    emit_signal("reply_cmd", {"name":"GUARD", "ability":reply_ability_gui.get_ability_dict()})
    deactivate()

func _on_MenuWaitButton_pressed():
    emit_signal("reply_cmd", {"name":"WAIT", "ability":reply_ability_gui.get_ability_dict()})
    deactivate()

func _on_TransparentButton_toggled(button_pressed):
    modulate = Color(1.0, 1.0, 1.0, max(int(!button_pressed), 0.3))

func on_reply_ability_cost_changed(cost, crest):
    menu_guard_button.disabled = crest=="DEFENSE" and cost+1 > attacked.player.crestpool.slots["DEFENSE"]

func on_select_monster_cancel_button_pressed():
    visible = true
    reply_ability_gui.on_select_monster_cancel_button_pressed()

func on_select_monster_select_button_pressed(tile):
    visible = true
    reply_ability_gui.on_select_monster_select_button_pressed(tile)
