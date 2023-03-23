extends MarginContainer

# variables
var ability_guis_dict
var active_gui

# reply ability guis
onready var reduce_damage_gui = $ReduceDamageGUI
onready var reduce_damage_inf_gui = $ReduceDamageInfGUI
onready var shift_damage_gui = $ShiftDamageGUI
onready var protect_self_gui = $ProtectSelfGUI
onready var add_foe_defense_gui = $AddFoeDefenseGUI

# signals
signal reply_ability_cost_changed(cost, crest)
signal reply_ability_select_monster

func _ready():
    reduce_damage_gui.connect("ability_cost_changed", self, "on_ability_cost_changed")
    reduce_damage_inf_gui.connect("ability_cost_changed", self, "on_ability_cost_changed")
    shift_damage_gui.connect("reply_ability_select_monster", self, "on_reply_ability_select_monster")
    ability_guis_dict = {"REDUCEDAMAGE"    : reduce_damage_gui,
                         "REDUCEDAMAGEINF" : reduce_damage_inf_gui,
                         "SHIFTDAMAGE"     : shift_damage_gui,
                         "PROTECTSELF"     : protect_self_gui,
                         "ADDFOEDEFENSE"   : add_foe_defense_gui}
    
# public functions
func activate(attacked):
    for ability in attacked.card.abilities:
        if ability.name in ability_guis_dict:
            active_gui = ability_guis_dict[ability.name]
            active_gui.set_reply_gui(attacked)
            active_gui.visible = true
            visible = true

func deactivate():
    visible = false
    active_gui.visible = false

func get_ability_dict():
    return active_gui.get_ability_dict()

# signals callbacks
func on_ability_cost_changed(cost, crest):
    emit_signal("reply_ability_cost_changed", cost, crest)

func on_reply_ability_select_monster():
    emit_signal("reply_ability_select_monster")

func on_select_monster_cancel_button_pressed():
    active_gui.on_select_monster_cancel_button_pressed()

func on_select_monster_select_button_pressed(tile):
    active_gui.on_select_monster_select_button_pressed(tile)
