extends Button

# setget functions
func set_reply_interface(monster):
    var ability = monster.get_ability("REDUCEDAMAGE")
    if ability.cost > monster.player.crestpool.slots[ability.crest]:
        disabled = true

func get_ability_dict():
    if pressed:
        return {"name":"REDUCEDAMAGE"}
    else:
        return null
