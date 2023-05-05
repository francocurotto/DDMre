extends VBoxContainer

#constants
const ability_range_highlight = ["RANGEKILLALL", "RANGELEVELKILL"]
const ability_guis_dict = {
    "TRADEHEALTH"    : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/standing_ability_gui/select_summon_gui/select_summon_gui.tscn"),
    "STEALMONSTER"   : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/standing_ability_gui/select_summon_gui/select_summon_gui.tscn"),
    "MINDCONTROL"    : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/standing_ability_gui/select_summon_gui/select_summon_gui.tscn"),
    #"KILLBLOCK"      : select_tile_gui
    "RANGELEVELKILL" : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/standing_ability_gui/range_level_kill_gui/range_level_kill_gui.tscn"),
    #"ROLLLEVELKILL"  : select_direction_gui
}

# variables
var ability
var active_gui

# onready variables
onready var ability_info = $AbilityInfo 
onready var controls = $Margins/Controls
onready var cast_button = $Margins/Controls/CastButton

# signals
signal cast_button_pressed(ability, ability_dict)
signal cancel_button_pressed
signal highlight_ability_tiles(tiles)
signal ability_select_tile

func _ready():
    #ability_info.set_ability(ability) # TODO: ability_info
    ability_info.text = ability.name
    cast_button.text = "✨CAST (%d%s)" % [ability.cost, Globals.CRESTICONS[ability.crest]]
    cast_button.disabled = ability.cost > ability.monster.player.crestpool.slots[ability.crest]
    if ability.name in ability_guis_dict:
        active_gui = ability_guis_dict[ability.name].instance().setup(self, ability)
        controls.add_child(active_gui)
        controls.move_child(active_gui, 0)
    if ability.name in ability_range_highlight:
        emit_signal("highlight_ability_tiles", ability.get_tiles_in_range(ability.tile_range))

# public functions
func setup(action_menu, _ability):
    ability = _ability
    connect("cast_button_pressed", action_menu, "on_standing_cast_button_pressed")
    connect("cancel_button_pressed", action_menu, "on_cancel_button_pressed")
    connect("highlight_ability_tiles", action_menu, "on_highlight_ability_tiles")
    connect("ability_select_tile", action_menu, "on_ability_select_tile")
    return self

func _on_CastButton_pressed():
    emit_signal("cast_button_pressed", ability.monster.tile.pos, get_ability_dict())

func _on_CancelButton_pressed():
    emit_signal("cancel_button_pressed")

func on_ability_cost_changed(cost, crest):
    cast_button.text = "✨CAST (%d%s)" % [cost, Globals.CRESTICONS[crest]]
    cast_button.disabled = cost > ability.monster.player.crestpool.slots[crest]

func on_ability_select_tile(tiles):
    emit_signal("ability_select_tile", tiles)

func on_select_tile_cancel_button_pressed():
    active_gui.on_select_tile_cancel_button_pressed()

func on_select_tile_select_button_pressed(tile):
    active_gui.on_select_tile_select_button_pressed(tile)

# private functions
func get_ability_dict():
    var ability_dict = {"name" : ability.name}
    if active_gui:
        ability_dict.merge(active_gui.get_ability_dict())
    return ability_dict
