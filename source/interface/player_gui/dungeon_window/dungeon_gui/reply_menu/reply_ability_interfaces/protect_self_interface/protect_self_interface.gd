extends Button

# variables
var cost
var crest

# setget functions
func set_reply_interface(interface):
    var ability = interface.attacked.get_ability("PROTECTSELF")
    cost = ability.cost
    crest = ability.crest
    text = "✨REDUCE DAMAGE 0 (%d%s)" % [cost, Globals.CRESTICONS[crest]] 
    disabled = cost > interface.attacked.player.crestpool.slots[crest]

func get_ability_dict():
    if pressed:
        return {"name":"PROTECTSELF"}
    else:
        return null
