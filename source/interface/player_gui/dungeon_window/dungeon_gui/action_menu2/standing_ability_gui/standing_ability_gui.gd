extends VBoxContainer

#constants
const ability_guis_dict = {
    #"REDUCEDAMAGE"    : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/reply_gui/button_gui/button_gui.tscn"),
    #"REDUCEDAMAGEINF" : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/reply_gui/reduce_damage_inf_gui/reduce_damage_inf_gui.tscn"),
    #"SHIFTDAMAGE"     : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/reply_gui/select_summon_gui/select_summon_gui.tscn"),
    #"PROTECTSELF"     : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/reply_gui/button_gui/button_gui.tscn"),
    #"ADDFOEDEFENSE"   : preload("res://interface/player_gui/dungeon_window/dungeon_gui/action_menu2/reply_gui/button_gui/button_gui.tscn")
}

# variables
var monster
var ability
var active_gui

# onready variables
onready var ability_info = $AbilityInfo 
onready var cast_button = $Margins/Controls/CastButton

# signals
signal cast_button_pressed(ability_dict)
signal cancel_button_pressed

func _ready():
    ability = monster.get_standing_ability()
    ability_info.set_ability(ability)
    cast_button.text = "✨CAST (%d%s)" % [ability.cost, Globals.CRESTICONS[ability.crest]]
    cast_button.disabled = ability.cost > monster.player.crestpool.slots[ability.crest]
    # get active ability gui

# public functions
func setup(action_menu, _monster):
    monster = _monster
    connect("cast_button_pressed", action_menu, "on_cast_button_pressed")
    connect("cancel_button_pressed", action_menu, "on_cancel_button_pressed")
    return self

func _on_CastButton_pressed():
    emit_signal("cast_button_pressed", {"name":"BUFFSELF"})

func _on_CancelButton_pressed():
    emit_signal("cancel_button_pressed")
