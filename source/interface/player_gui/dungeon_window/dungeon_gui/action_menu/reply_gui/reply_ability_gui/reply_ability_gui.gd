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
signal reply_ability_select_tile

func _ready():
    reduce_damage_gui.connect("ability_cost_changed", self, "on_ability_cost_changed")
    reduce_damage_inf_gui.connect("ability_cost_changed", self, "on_ability_cost_changed")
    shift_damage_gui.connect("ability_select_tile", self, "on_ability_select_tile")
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
    if active_gui:
        active_gui.visible = false

func get_ability_dict():
    if active_gui:
        return active_gui.get_ability_dict()
    else:
        return {}
    
# signals callbacks
func on_ability_cost_changed(cost, crest):
    emit_signal("reply_ability_cost_changed", cost, crest)

func on_ability_select_tile(tiles):
    emit_signal("reply_ability_select_tile", tiles)

func on_select_tile_cancel_button_pressed():
    active_gui.on_select_tile_cancel_button_pressed()

func on_select_tile_select_button_pressed(tile):
    active_gui.on_select_tile_select_button_pressed(tile)
