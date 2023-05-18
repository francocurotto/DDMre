extends Button

# variables
var ability
var poslist

# signals
signal select_summons_gui_toggled

# public functions
func setup(ability_gui, _ability):
    ability = _ability
    connect("select_summons_gui_toggled", ability_gui, "on_select_summons_gui_toggled")
    _on_SelectSummonsGUI_toggled(false)
    return self

func get_ability_dict():
    if pressed:
        return {"name":ability.name, "poslist":poslist}
    else:
        return {}

# signals callbacks
func _on_SelectSummonsGUI_toggled(button_pressed):
    emit_signal("select_summons_gui_toggled", button_pressed)

func on_select_summons_done_button_pressed(_poslist):
    if not _poslist.empty():
        pressed = true
        poslist = _poslist
    else:
        pressed = false
