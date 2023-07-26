extends VBoxContainer

func set_abilities(card):
    for child in get_children():
        child.visible = false
        
    for i in range(len(card.abilities)):
        var ability = card.abilities[i]
        var ability_info = get_children()[i]
        ability_info.set_ability(ability)
        ability_info.visible = true
