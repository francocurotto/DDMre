extends Button

# variables
var cost
var crest

# signals
signal ability_cost_changed(cost, crest)

# setget functions
func set_reply_interface(monster):
    var ability = monster.get_ability("REDUCEDAMAGE")
    cost = ability.cost
    crest = ability.crest
    text = "REDUCE DAMAGE -%d (+%d%s)" % [ability.amount, cost, Globals.CRESTICONS[crest]] 
    disabled = cost > monster.player.crestpool.slots[crest]

func get_ability_dict():
    if pressed:
        return {"name":"REDUCEDAMAGE"}
    else:
        return null

# signals callbacks
func _on_Button_toggled(button_pressed):
    if button_pressed:
        emit_signal("ability_cost_changed", cost, crest)
    else:
        emit_signal("ability_cost_changed", 0, crest)
