@tool
extends VBoxContainer

# public functions
func setup(abilities):
    # reset abilities
    $AbilityInfo1.modulate = Color(1,1,1,0)
    $AbilityInfo2.modulate = Color(1,1,1,0)
    # set new abilities
    for i in len(abilities):
        var ability_info = get_child(i)
        var ability_entry = Globals.ABIDICT[abilities[i].name]
        ability_info.ability_name = ability_entry["NAME"]
        ability_info.modulate = Color(1,1,1,1)
        
