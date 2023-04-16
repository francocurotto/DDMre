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
onready var trade_health_gui = $TradeHealthGUI
onready var steal_monster_gui = $StealMonsterGUI
onready var mind_control_gui = $MindControlGUI
onready var kill_block_gui = $KillBlockGUI
onready var range_level_kill_gui = $RangeLevelKillGUI

# signals
signal ability_cmd(cmd)
signal ability_cancel_button_pressed
signal highlight_ability_tiles(tiles)
signal ability_select_tile(tiles)

func _ready():
    range_kill_all_gui.connect("highlight_ability_tiles", self, "on_highlight_ability_tiles")
    trade_health_gui.connect("ability_select_tile", self, "on_ability_select_tile")
    steal_monster_gui.connect("ability_select_tile", self, "on_ability_select_tile")
    mind_control_gui.connect("ability_select_tile", self, "on_ability_select_tile")
    kill_block_gui.connect("ability_select_tile", self, "on_ability_select_tile")
    range_level_kill_gui.connect("highlight_ability_tiles", self, "on_highlight_ability_tiles")
    range_level_kill_gui.connect("ability_select_tile", self, "on_ability_select_tile")
    ability_guis_dict = {"BUFFSELF"       : buff_self_gui,
                         "BUFFDAMAGE"     : buff_damage_gui,
                         "DISTANCEATTACK" : distance_attack_gui,
                         "RANGEKILLALL"   : range_kill_all_gui,
                         "TRADEHEALTH"    : trade_health_gui,
                         "STEALMONSTER"   : steal_monster_gui,
                         "MINDCONTROL"    : mind_control_gui,
                         "KILLBLOCK"      : kill_block_gui,
                         "RANGELEVELKILL" : range_level_kill_gui}

# public functions
func activate(tile):
    pos = tile.pos
    for ability in tile.content.card.abilities:
        if ability.name in ability_guis_dict:
            active_gui = ability_guis_dict[ability.name]
            active_gui.activate(tile.content)
            active_gui.connect("cast_button_pressed", self, "on_cast_button_pressed")
            active_gui.connect("cancel_button_pressed", self, "on_cancel_button_pressed")
            visible = true

# signals callbacks
func on_cast_button_pressed(ability_dict):
    visible = false
    active_gui.disconnect("cast_button_pressed", self, "on_cast_button_pressed")
    active_gui.disconnect("cancel_button_pressed", self, "on_cancel_button_pressed")
    emit_signal("ability_cmd", {"name":"ABILITY", "pos":pos, "ability":ability_dict})

func on_cancel_button_pressed():
    visible = false
    active_gui.disconnect("cast_button_pressed", self, "on_cast_button_pressed")
    active_gui.disconnect("cancel_button_pressed", self, "on_cancel_button_pressed")
    emit_signal("ability_cancel_button_pressed")

func on_highlight_ability_tiles(tiles):
    emit_signal("highlight_ability_tiles", tiles)

func on_check_dungeon_button_pressed():
    emit_signal("check_dungeon_button_pressed")

func on_ability_select_tile(tiles):
    emit_signal("ability_select_tile", tiles)

func on_select_tile_cancel_button_pressed():
    active_gui.on_select_tile_cancel_button_pressed()

func on_select_tile_select_button_pressed(tile):
    active_gui.on_select_tile_select_button_pressed(tile)
