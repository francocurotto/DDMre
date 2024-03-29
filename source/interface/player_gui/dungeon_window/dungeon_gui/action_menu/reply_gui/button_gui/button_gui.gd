extends Button

# variables
var ability

# signals
signal ability_cost_changed(cost, crest)

func _ready():
    text = get_button_text()
    disabled = ability.cost > ability.summon.player.crestpool.get_crest(ability.crest)

# public functions
func setup(reply_gui, _ability):
    ability = _ability
    connect("ability_cost_changed", reply_gui, "on_ability_cost_changed")
    return self

func get_ability_dict():
    if pressed:
        return {"name":ability.name}
    else:
        return {}

# signals callbacks
func _on_ButtonGUI_toggled(button_pressed):
    emit_signal("ability_cost_changed", int(button_pressed)*0, ability.crest) # TODO: check * (does not make sense)

# private functions
func get_button_text():
    return "✨%s (%d%s)" % [Globals.ABIDICT[ability.name]["NAME"], ability.cost, Globals.CRESTICONS[ability.crest]]
