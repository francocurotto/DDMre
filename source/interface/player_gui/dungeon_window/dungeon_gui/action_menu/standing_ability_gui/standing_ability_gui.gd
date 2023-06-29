extends VBoxContainer

#constants
const ability_range_highlight = ["RANGEKILLALL", "RANGELEVELKILL"]
const ability_guis_dict = {
    "TRADEHEALTH"    : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/standing_ability_gui/select_summon_gui/select_summon_gui.tscn"),
    "STEALMONSTER"   : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/standing_ability_gui/select_summon_gui/select_summon_gui.tscn"),
    "MINDCONTROL"    : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/standing_ability_gui/select_summon_gui/select_summon_gui.tscn"),
    "KILLBLOCK"      : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/standing_ability_gui/select_tile_gui/select_tile_gui.tscn"),
    "RANGELEVELKILL" : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/standing_ability_gui/range_level_kill_gui/range_level_kill_gui.tscn"),
    "ROLLLEVELKILL"  : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/standing_ability_gui/roll_level_kill_gui/roll_level_kill_gui.tscn"),
    "NEGATEATKABI"   : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu/standing_ability_gui/select_summon_gui/select_summon_gui.tscn")
}

# variables
var ability
var active_gui

# onready variables
onready var ability_info = $AbilityInfo 
onready var controls = $Margins/Controls
onready var cast_button = $Margins/Controls/CastButton

# signals
signal cast_button_pressed(pos, ability_dict)
signal cancel_button_pressed
signal highlight_ability_tiles(tiles)
signal select_tile_gui_pressed(tiles)
signal select_direction_pressed(ability, direction)

func _ready():
    ability_info.set_ability(ability)
    on_ability_cost_changed(ability.COST)
    if ability.name in ability_guis_dict:
        active_gui = ability_guis_dict[ability.name].instance().setup(self, ability)
        controls.add_child(active_gui)
        controls.move_child(active_gui, 0)
    if ability.name in ability_range_highlight:
        emit_signal("highlight_ability_tiles", ability.get_tiles_in_range(ability.RANGE))

# public functions
func setup(action_menu, _ability):
    ability = _ability
    connect("cast_button_pressed", action_menu, "on_standing_cast_button_pressed")
    connect("cancel_button_pressed", action_menu, "on_cancel_button_pressed")
    connect("highlight_ability_tiles", action_menu, "on_highlight_ability_tiles")
    connect("select_tile_gui_pressed", action_menu, "on_select_tile_gui_pressed")
    connect("select_direction_pressed", action_menu, "on_select_direction_pressed")
    return self

# signals callbacks
func _on_CastButton_pressed():
    emit_signal("cast_button_pressed", ability.monster.tile.pos, get_ability_dict())

func _on_CancelButton_pressed():
    emit_signal("cancel_button_pressed")

func on_highlight_ability_tiles(tiles):
    emit_signal("highlight_ability_tiles", tiles)

func on_select_tile_gui_toggled(pressed):
    if pressed:
        emit_signal("select_tile_gui_pressed", ability.get_select_tiles())
    else:
        cast_button.disabled = true

func on_select_direction_pressed(direction):
    emit_signal("select_direction_pressed", ability, direction)

func on_select_tile_cancel_button_pressed():
    active_gui.on_select_tile_cancel_button_pressed()
    cast_button.disabled = true

func on_select_tile_select_button_pressed(tile):
    active_gui.on_select_tile_select_button_pressed(tile)
    cast_button.disabled = ability.COST > ability.monster.player.crestpool.get_crest(ability.CREST)

func on_select_direction_select_button_pressed(direction):
    active_gui.on_select_direction_select_button_pressed(direction)

func on_ability_cost_changed(cost):
    cast_button.text = "✨CAST (%d%s)" % [cost, Globals.CRESTICONS[ability.CREST]]
    cast_button.disabled = cost > ability.monster.player.crestpool.get_crest(ability.CREST) 

# private functions
func get_ability_dict():
    var ability_dict = {"name" : ability.name}
    if active_gui:
        ability_dict.merge(active_gui.get_ability_dict())
    return ability_dict
