extends VBoxContainer

# constants
const SummonInfo = preload("res://interface/player_gui/info_display/summon_info/summon_info.tscn")

# variables
var ability
var poslist

# onready variables
onready var button = $Button
onready var summon_infos = $SummonInfos

# signals
signal select_summons_gui_toggled

# public functions
func setup(ability_gui, _ability):
    ability = _ability
    connect("select_summons_gui_toggled", ability_gui, "on_select_summons_gui_toggled")
    #_on_Button_toggled(false)
    ability_gui.ability_castable(false)
    return self

func get_ability_dict():
    if button.pressed:
        return {"name":ability.name, "poslist":poslist}
    else:
        return {}

# signals callbacks
func _on_Button_toggled(button_pressed):
    emit_signal("select_summons_gui_toggled", button_pressed)
    if not button_pressed:
        for child in summon_infos.get_children():
            child.queue_free()
    
func on_select_summons_done_button_pressed(_poslist):
    if not _poslist.empty():
        button.pressed = true
        poslist = _poslist
        for pos in poslist:
            var summon = ability.dungeon.get_tile(pos).content
            var summon_info = SummonInfo.instance()
            summon_infos.add_child(summon_info)
            summon_info.set_summon(summon, ability.monster.player)
            
             
    else:
        button.pressed = false
