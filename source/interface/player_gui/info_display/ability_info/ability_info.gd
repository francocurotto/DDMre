extends VBoxContainer

# onready variables
onready var ability_name = $AbilityName
onready var ability_desc = $AbilityDesc

# setget functions
func set_ability(ability):
    var ability_info = Globals.ability_dict[ability.name]
    ability_name.text = ability_info["NAME"]
    if not ability_info["DESCRIPTION"].empty():
        var description = format_description(ability, ability_info)
        ability_desc.text = "[%s]: %s" % [ability_info["TYPE"], description]
        ability_desc.visible = true
    else:
        ability_desc.visible = false

# private functions
func format_description(ability, ability_info):
    var format_dict = {}
    for param in ability_info["PARAMETERS"]:
        format_dict[param] = ability.get(param)
    print(ability_info["DESCRIPTION"])
    print(format_dict)
    return ability_info["DESCRIPTION"] % format_dict
