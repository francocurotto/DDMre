extends Reference

var name

func _init(ability_info):
    name = ability_info["NAME"]

# is functions
func is_ability():
    return true
