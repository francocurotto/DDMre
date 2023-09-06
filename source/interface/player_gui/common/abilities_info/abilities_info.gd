extends HBoxContainer

# public functions
func setup(abilities):
    # reset abilities
    $AbilityInfo1.visible = false
    $AbilityInfo2.visible = false
    # set new abilities
    for i in len(abilities):
        var ability_info = get_child(i)
        var ability_entry = Globals.ABIDICT[abilities[i].name]
        ability_info.ability_name = ability_entry["NAME"]
        ability_info.visible = true
        
