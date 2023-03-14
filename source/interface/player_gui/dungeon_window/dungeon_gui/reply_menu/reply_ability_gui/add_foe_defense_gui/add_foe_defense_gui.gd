extends Button

# variables
var cost
var crest

# setget functions
func set_reply_interface(attacked):
    var ability = attacked.get_ability("ADDFOEDEFENSE")
    cost = ability.cost
    crest = ability.crest
    text = "✨ADD FOE DEFENSE (%d%s)" % [cost, Globals.CRESTICONS[crest]] 
    disabled = cost > attacked.player.crestpool.slots[crest]

func get_ability_dict():
    if pressed:
        return {"name":"ADDFOEDEFENSE"}
    else:
        return null
