extends Button

# variables
var cost
var crest

# signals
signal ability_cost_changed(cost, crest)

# setget functions
func set_reply_interface(monster):
    var ability = monster.get_ability("PROTECTSELF")
    cost = ability.cost
    crest = ability.crest
    text = "✨REDUCE DAMAGE 0 (%d%s)" % [cost, Globals.CRESTICONS[crest]] 
    disabled = cost > monster.player.crestpool.slots[crest]

func get_ability_dict():
    if pressed:
        return {"name":"PROTECTSELF"}
    else:
        return null
