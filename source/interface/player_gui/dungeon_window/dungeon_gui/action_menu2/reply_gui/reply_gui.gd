extends VBoxContainer

const ability_guis_dict = {
    "REDUCEDAMAGE"    : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/reply_gui/button_gui/button_gui.tscn"),
    "REDUCEDAMAGEINF" : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/reply_gui/reduce_damage_inf_gui/reduce_damage_inf_gui.tscn"),
    "SHIFTDAMAGE"     : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/reply_gui/select_summon_gui/select_summon_gui.tscn"),
    "PROTECTSELF"     : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/reply_gui/button_gui/button_gui.tscn"),
    "ADDFOEDEFENSE"   : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/reply_gui/button_gui/button_gui.tscn")
   }

# variables
var attacker
var attacked
var reply_ability_gui

# onready variables
onready var attack_info = $AttackInfo
onready var controls = $Margins/Controls
onready var guard_button = $Margins/Controls/GuardButton

# singals
signal reply_button_pressed(cmd, ability_dict)
signal ability_select_tile(tiles)

func _ready():
    attack_info.set_summons(attacker, attacker.player, attacked, attacked.player)
    guard_button.disabled = attacked.player.crestpool.slots["DEFENSE"] < 1
    for ability in attacked.card.abilities:
        if ability.name in ability_guis_dict:
            reply_ability_gui = ability_guis_dict[ability.name].instance().setup(self, ability)
            controls.add_child(reply_ability_gui)
            controls.move_child(reply_ability_gui, 0)

# public functions
func setup(action_menu, _attacker, _attacked):
    attacker = _attacker
    attacked = _attacked
    connect("reply_button_pressed", action_menu, "on_reply_button_pressed")
    connect("ability_select_tile", action_menu, "on_ability_select_tile")
    return self

# signals callbacks
func _on_GuardButton_pressed():
    emit_signal("reply_button_pressed", "GUARD", get_ability_dict())

func _on_WaitButton_pressed():
    emit_signal("reply_button_pressed", "WAIT", get_ability_dict())

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
        return reply_ability_gui.get_ability_dict()
    else:
        return {}
