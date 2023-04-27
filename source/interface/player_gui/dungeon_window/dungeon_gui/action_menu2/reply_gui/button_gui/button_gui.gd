extends Button

# variables
var ability
var cost
var crest

# signals
signal ability_cost_changed(cost, crest)

# setget functions
func setup(reply_gui, _ability):
    ability = _ability
    cost = ability.cost
    crest = ability.crest
    text = "✨%d (%d%s)" % [ability.name, cost, Globals.CRESTICONS[crest]]
    disabled = cost > ability.monster.player.crestpool.slots[crest]
    connect("ability_cost_changed", reply_gui, "on_ability_cost_changed")

func get_ability_dict():
    if pressed:
        return {"name":ability.name}
    else:
        return null

func _on_ButtonGUI_toggled(button_pressed):
    if button_pressed:
        emit_signal("ability_cost_changed", cost, crest)
    else:
        emit_signal("ability_cost_changed", 0, crest)
