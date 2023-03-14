extends PanelContainer

# variables
var attacked
var ability_interface

# onready variables
onready var attack_info = $VBox/AttackInfo
onready var transparent_button = $VBox/TransparentButton
onready var buttons = $VBox/Margins/Buttons
onready var menu_guard_button = $VBox/Margins/Buttons/MenuGuardButton
# reply ability guis
onready var reduce_damage_gui = $VBox/Margins/Buttons/ReplyAbilityGUIs/ReduceDamageGUI
onready var reduce_damage_inf_gui = $VBox/Margins/Buttons/ReplyAbilityGUIs/ReduceDamageInfGUI
onready var shift_damage_gui = $VBox/Margins/Buttons/ReplyAbilityGUIs/ShiftDamageGUI
onready var protect_self_gui = $VBox/Margins/Buttons/ReplyAbilityGUIs/ProtectSelfGUI
onready var add_foe_defense_gui = $VBox/Margins/Buttons/ReplyAbilityGUIs/AddFoeDefenseGUI
var ability_interfaces_dict = {"REDUCEDAMAGE"    : reduce_damage_gui,
                               "REDUCEDAMAGEINF" : reduce_damage_inf_gui,
                               "SHIFTDAMAGE"     : shift_damage_gui,
                               "PROTECTSELF"     : protect_self_gui,
                               "ADDFOEDEFENSE"   : add_foe_defense_gui}

# singals
signal reply_cmd
signal shiftdamage_button_pressed

# public functions
func activate(_attacker, _attacked):
    attacked = _attacked
    attack_info.set_summons(_attacker, _attacker.player, attacked, attacked.player)
    menu_guard_button.disabled = attacked.player.crestpool.slots["DEFENSE"] < 1
    for ability in attacked.card.abilities:
        if ability.name in ability_interfaces_dict and not ability.is_negated(): # disable ability gui on negated instead of not show?
            ability_interface.set_reply_interface(self)
    visible = true
    transparent_button.pressed = false

func deactivate():
    visible = false
    menu_guard_button.disabled = false
    if ability_interface:
        ability_interface.queue_free() 

# signals callbacks
func _on_MenuGuardButton_pressed():
    deactivate()
    emit_signal("reply_cmd", {"name":"GUARD", "ability":get_ability_dict()})

func _on_MenuWaitButton_pressed():
    deactivate()
    emit_signal("reply_cmd", {"name":"WAIT", "ability":get_ability_dict()})

func _on_TransparentButton_toggled(button_pressed):
    modulate = Color(1.0, 1.0, 1.0, max(int(!button_pressed), 0.3))

func on_ability_cost_changed(cost, crest):
    menu_guard_button.disabled = crest=="DEFENSE" and cost+1 > attacked.player.crestpool.slots["DEFENSE"]

func on_shiftdamage_button_pressed():
    visible = false
    emit_signal("shiftdamage_button_pressed")

func on_cancel_reply_ability_button_pressed():
    visible = true
    ability_interface.on_cancel_reply_ability_button_pressed()

func on_select_reply_ability_button_pressed(tile):
    visible = true
    ability_interface.on_select_reply_ability_button_pressed(tile)

# private functions
func get_ability_dict():
    """
    If no reply ability interface, return null, else check with reply ability
    interface for ability dict.
    """
    if not ability_interface:
        return null
    else:
        return ability_interface.get_ability_dict()
