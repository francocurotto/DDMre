extends VBoxContainer

# variables
var attacked
var ability_guis_dict
var ability_gui setget , get_ability_gui

# onready variables
onready var attack_info = $AttackInfo
onready var menu_guard_button = $Margins/GUIVBox/MenuGuardButton
onready var ability_guis = $Margins/GUIVBox/AbilityGUIs
onready var reduce_damage_gui = $Margins/GUIVBox/AbilityGUIs/ReduceDamageGUI
onready var reduce_damage_inf_gui = $Margins/GUIVBox/AbilityGUIs/ReduceDamageInfGUI
onready var shift_damage_gui = $Margins/GUIVBox/AbilityGUIs/ShiftDamageGUI
onready var protect_self_gui = $Margins/GUIVBox/AbilityGUIs/ProtectSelfGUI
onready var add_foe_defense_gui = $Margins/GUIVBox/AbilityGUIs/AddFoeDefenseGUI

# singals
signal reply_cmd(cmd)
signal reply_ability_cost_changed(cost, crest)
signal ability_select_tile

func _ready():
    reduce_damage_gui.connect("ability_cost_changed", self, "on_ability_cost_changed")
    reduce_damage_inf_gui.connect("ability_cost_changed", self, "on_ability_cost_changed")
    shift_damage_gui.connect("ability_select_tile", self, "on_ability_select_tile")
    ability_guis_dict = {"REDUCEDAMAGE"    : reduce_damage_gui,
                         "REDUCEDAMAGEINF" : reduce_damage_inf_gui,
                         "SHIFTDAMAGE"     : shift_damage_gui,
                         "PROTECTSELF"     : protect_self_gui,
                         "ADDFOEDEFENSE"   : add_foe_defense_gui}

# setget functions
func get_ability_gui():
    for gui in ability_guis.get_children():
        if gui.visible:
            return gui

# public functions
func activate(_attacker, _attacked):
    attacked = _attacked
    attack_info.set_summons(_attacker, _attacker.player, attacked, attacked.player)
    menu_guard_button.disabled = attacked.player.crestpool.slots["DEFENSE"] < 1
    for ability in attacked.card.abilities:
        if ability.name in ability_guis_dict:
            ability_guis_dict[ability.name].visible = true
            self.ability_gui.set_reply_gui(attacked)
    visible = true

func deactivate():
    menu_guard_button.disabled = false
    self.ability_gui.visible = false
    visible = false

# signals callbacks
func _on_MenuGuardButton_pressed():
    emit_signal("reply_cmd", {"name":"GUARD", "ability":get_ability_dict()})
    deactivate()

func _on_MenuWaitButton_pressed():
    emit_signal("reply_cmd", {"name":"WAIT", "ability":get_ability_dict()})
    deactivate()

func on_ability_cost_changed(cost, crest):
    menu_guard_button.disabled = crest=="DEFENSE" and cost+1 > attacked.player.crestpool.slots["DEFENSE"]

func on_ability_select_tile(tiles):
    emit_signal("ability_select_tile", tiles)

func on_select_tile_cancel_button_pressed():
    self.ability_gui.on_select_tile_cancel_button_pressed()

func on_select_tile_select_button_pressed(tile):
    self.ability_gui.on_select_tile_select_button_pressed(tile)

# private functions
func get_ability_dict():
    if self.ability_gui:
        return self.ability_gui.get_ability_dict()
    else:
        return {}
