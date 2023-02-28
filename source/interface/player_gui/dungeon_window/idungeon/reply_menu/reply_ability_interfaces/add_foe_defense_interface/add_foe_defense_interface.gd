extends Button

# variables
var cost
var crest

# signals
signal ability_cost_changed(cost, crest)

# setget functions
func set_reply_interface(monster):
    var ability = monster.get_ability("ADDFOEDEFENSE")
    cost = ability.cost
    crest = ability.crest
    text = "✨ADD FOE DEFENSE (%d%s)" % [cost, Globals.CRESTICONS[crest]] 
    disabled = cost > monster.player.crestpool.slots[crest]

func get_ability_dict():
    if pressed:
        return {"name":"ADDFOEDEFENSE"}
    else:
        return null
