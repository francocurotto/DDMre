extends PanelContainer

# preloads
const ReduceDamageInterface = preload("res://interface/player_gui/dungeon_window/idungeon/reply_menu/reply_ability_interfaces/reduce_damage_interface/reduce_damage_interface.tscn")
const ability_interfaces_dict = {"REDUCEDAMAGE" : ReduceDamageInterface}

# variables
var ability_interface

# onready variables
onready var attack_info = $VBox/AttackInfo
onready var transparent_button = $VBox/TransparentButton
onready var buttons = $VBox/Margins/Buttons

# singals
signal reply_cmd

# public functions
func activate(attacker, attacked):
    attack_info.set_summons(attacker, attacker.player, attacked, attacked.player)
    for ability in attacked.card.abilities:
        if ability.name in ability_interfaces_dict and not ability.is_negated():
            ability_interface = ability_interfaces_dict[ability.name].instance()
            #ability_interface.connect("attack_ability_activated", self, "on_attack_ability_activated")
            ability_interface.set_reply_interface(attacked)
            buttons.add_child(ability_interface)
            buttons.move_child(ability_interface, 0)
    visible = true
    transparent_button.pressed = false

# signals callbacks
func _on_MenuGuardButton_pressed():
    visible = false
    emit_signal("reply_cmd", {"name":"GUARD", "ability":get_ability_dict()})

func _on_MenuWaitButton_pressed():
    visible = false
    emit_signal("reply_cmd", {"name":"WAIT", "ability":get_ability_dict()})

func _on_TransparentButton_toggled(button_pressed):
    modulate = Color(1.0, 1.0, 1.0, max(int(!button_pressed), 0.3))

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
