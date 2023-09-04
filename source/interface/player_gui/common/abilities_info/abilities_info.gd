extends HBoxContainer

# public functions
func setup(abilities):
    # reset abilities
    $AbilityInfo1.ability_name = ""
    $AbilityInfo2.ability_name = ""
    # set new abilities
    for i in len(abilities):
        get_child(i).ability_name = abilities[i].name
        
