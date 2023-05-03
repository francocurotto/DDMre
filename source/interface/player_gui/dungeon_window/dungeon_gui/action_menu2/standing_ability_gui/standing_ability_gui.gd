extends VBoxContainer

#constants
const ability_range_highlight = ["RANGEKILLALL", "RANGELEVELKILL"]
const ability_guis_dict = {
    #"TRADEHEALTH"    : select_summon_gui
    #"STEALMONSTER"   : select_summon_gui
    #"MINDCONTROL"    : select_summon_gui
    #"KILLBLOCK"      : select_tile_gui
    #"RANGELEVELKILL" : select_summon_gui
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
        

# public functions
func setup(action_menu, _ability):
    ability = _ability
    connect("cast_button_pressed", action_menu, "on_standing_cast_button_pressed")
    connect("cancel_button_pressed", action_menu, "on_cancel_button_pressed")
    return self

func _on_CastButton_pressed():
    emit_signal("cast_button_pressed", ability.monster.tile.pos, get_ability_dict())

func _on_CancelButton_pressed():
    emit_signal("cancel_button_pressed")

# private functions
func get_ability_dict():
    var ability_dict = {"name" : ability.name}
    if active_gui:
        ability_dict += active_gui.get_ability_dict()
    return ability_dict
