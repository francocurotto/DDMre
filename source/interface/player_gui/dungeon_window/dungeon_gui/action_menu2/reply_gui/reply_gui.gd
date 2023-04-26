extends VBoxContainer

const ability_gui_dict = {
    "REDUCEDAMAGE"    : preload("button_gui.tscn"),
    "REDUCEDAMAGEINF" : preload("reduce_damage_inf_gui.tscn"),
    "SHIFTDAMAGE"     : preload("select_tile_gui.tscn"),
    "PROTECTSELF"     : preload("button_gui.tscn"),
    "ADDFOEDEFENSE"   : preload("button_gui.tscn")
   }

# variables
var attacked
var reply_ability_gui

# onready variables
onready var attack_info = $AttackInfo
onready var guard_button = $Margins/Control/GuardButton

# singals
signal reply_button_pressed(cmd, ability)
signal ability_select_tile(tiles)

func _ready():
    reduce_damage_gui.connect("ability_cost_changed", self, "on_ability_cost_changed")
    reduce_damage_inf_gui.connect("ability_cost_changed", self, "on_ability_cost_changed")
    shift_damage_gui.connect("ability_select_tile", self, "on_ability_select_tile")

# public functions
func activate(action_menu, _attacker, _attacked):
    attacked = _attacked
    attack_info.set_summons(_attacker, _attacker.player, attacked, attacked.player)
    guard_button.disabled = attacked.player.crestpool.slots["DEFENSE"] < 1
    for ability in attacked.card.abilities:
        if ability.name in ability_guis_dict:
            reply_ability_gui = ability_guis_dict[ability.name].instance().setup(ability, attacked)
    connect("reply_button_pressed", action_menu, "on_reply_button_pressed")
    connect("ability_select_tile", action_menu, "on_ability_select_tile")
    action_menu.add_child(self)
    return self

# signals callbacks
func _on_GuardButton_pressed():
    emit_signal("reply_button_pressed", "GUARD", get_ability_dict())
    deactivate()

func _on_WaitButton_pressed():
    emit_signal("reply_button_pressed", "WAIT", get_ability_dict())
    deactivate()

func on_ability_cost_changed(cost, crest):
    guard_button.disabled = crest=="DEFENSE" and cost+1 > attacked.player.crestpool.slots["DEFENSE"]

func on_ability_select_tile(tiles):
    emit_signal("ability_select_tile", tiles)

func on_select_tile_cancel_button_pressed():
    reply_ability_gui.on_select_tile_cancel_button_pressed()

func on_select_tile_select_button_pressed(tile):
    reply_ability_gui.on_select_tile_select_button_pressed(tile)

# private functions
func get_ability_dict():
    if reply_ability_gui:
        return ability_gui.get_ability_dict()
    else:
        return {}
