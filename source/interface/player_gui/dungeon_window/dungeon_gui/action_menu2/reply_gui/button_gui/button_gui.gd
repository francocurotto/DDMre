extends Button

# variables
var ability
var cost
var crest

# signals
signal ability_cost_changed(cost, crest)

func _ready():
    cost = ability.cost
    crest = ability.crest
    text = get_button_text()
    disabled = cost > ability.monster.player.crestpool.slots[crest]

# public functions
func setup(reply_gui, _ability):
    ability = _ability
    connect("ability_cost_changed", reply_gui, "on_ability_cost_changed")
    return self

func get_ability_dict():
    if pressed:
        return {"name":ability.name}
    else:
        return null

# signals callbacks
func _on_ButtonGUI_toggled(button_pressed):
    if button_pressed:
        emit_signal("ability_cost_changed", cost, crest)
    else:
        emit_signal("ability_cost_changed", 0, crest)

# private functions
func get_button_text():
    match ability.name:
        "REDUCEDAMAGE" :
            return "✨%s -%d (%d%s)" % [ability.name, ability.amount, cost, Globals.CRESTICONS[crest]]
        _ : 
            return "✨%s (%d%s)" % [ability.name, cost, Globals.CRESTICONS[crest]]
            
