extends MarginContainer

# variables
var summon
var ability_guis_dict
var active_gui

# onready variables
onready var dim_kill_tunnel_all_gui = $DimKillTunnelAllGUI
onready var dim_trade_crest_gui = $DimTradeCrestGUI

# signals
signal ability_cmd(cmd)
signal skip_cmd
signal ability_select_tile(tiles)

func _ready():
    ability_guis_dict = {"DIMKILLTUNNELALL" : dim_kill_tunnel_all_gui,
                         "DIMTRADECREST"    : dim_trade_crest_gui}

# public functions
func activate(_summon):
    summon = _summon
    for ability in summon.card.abilities:
        if ability.name in ability_guis_dict:
            active_gui = ability_guis_dict[ability.name]
            active_gui.activate(summon)
            active_gui.connect("cast_button_pressed", self, "on_cast_button_pressed")
            active_gui.connect("skip_button_pressed", self, "on_skip_button_pressed")
            visible = true

# signals callbacks
func on_cast_button_pressed(ability_dict):
    visible = false
    active_gui.disconnect("cast_button_pressed", self, "on_cast_button_pressed")
    active_gui.disconnect("skip_button_pressed", self, "on_skip_button_pressed")
    emit_signal("ability_cmd", {"name":"ABILITY", "ability":ability_dict})

func on_skip_button_pressed():
    visible = false
    active_gui.disconnect("cast_button_pressed", self, "on_cast_button_pressed")
    active_gui.disconnect("skip_button_pressed", self, "on_skip_button_pressed")
    emit_signal("skip_cmd", {"name":"SKIP"})

func on_highlight_ability_tiles(tiles):
    emit_signal("highlight_ability_tiles", tiles)

func on_ability_select_tile(tiles):
    emit_signal("ability_select_tile", tiles)


func on_select_tile_cancel_button_pressed():
    active_gui.on_select_tile_cancel_button_pressed()

func on_select_tile_select_button_pressed(tile):
    active_gui.on_select_tile_select_button_pressed(tile)
