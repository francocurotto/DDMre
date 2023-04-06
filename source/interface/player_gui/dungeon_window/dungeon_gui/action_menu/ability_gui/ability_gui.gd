extends MarginContainer

# variables
var pos
var ability_guis_dict
var active_gui

# onready variables
onready var buff_self_gui = $BuffSelfGUI
onready var buff_damage_gui = $BuffDamageGUI
onready var distance_attack_gui = $DistanceAttackGUI
onready var range_kill_all_gui = $RangeKillAllGUI

# signals
signal ability_cmd(cmd)
signal ability_cancel_button_pressed
signal check_dungeon_button_pressed

func _ready():
    ability_guis_dict = {"BUFFSELF"       : buff_self_gui,
                         "BUFFDAMAGE"     : buff_damage_gui,
                         "DISTANCEATTACK" : distance_attack_gui,
                         "RANGEKILLALL"   : range_kill_all_gui}

# public functions
func activate(tile):
    pos = tile.pos
    for ability in tile.content.card.abilities:
        if ability.name in ability_guis_dict:
            active_gui = ability_guis_dict[ability.name]
            active_gui.activate(tile.content)
            active_gui.connect("cast_button_pressed", self, "on_cast_button_pressed")
            active_gui.connect("cancel_button_pressed", self, "on_cancel_button_pressed")
            active_gui.connect("check_dungeon_button_pressed", self, "on_check_dungeon_button_pressed")
            visible = true

# signals callbacks
func on_cast_button_pressed(ability_dict):
    visible = false
    active_gui.disconnect("cast_button_pressed", self, "on_cast_button_pressed")
    active_gui.disconnect("cancel_button_pressed", self, "on_cancel_button_pressed")
    active_gui.disconnect("check_dungeon_button_pressed", self, "on_check_dungeon_button_pressed")
    emit_signal("ability_cmd", {"name":"ABILITY", "pos":pos, "ability":ability_dict})

func on_cancel_button_pressed():
    visible = false
    active_gui.disconnect("cast_button_pressed", self, "on_cast_button_pressed")
    active_gui.disconnect("cancel_button_pressed", self, "on_cancel_button_pressed")
    active_gui.disconnect("check_dungeon_button_pressed", self, "on_check_dungeon_button_pressed")
    emit_signal("ability_cancel_button_pressed")

func on_check_dungeon_button_pressed():
    emit_signal("check_dungeon_button_pressed")
