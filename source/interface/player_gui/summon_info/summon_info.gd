extends PanelContainer

# signals callbacks
func on_tile_gui_toggled(tile_gui, toggled_on):
    var content = tile_gui.tile.content
    if toggled_on and content.is_summon():
        # set name
        %Name.text = content.card.name
        # set level
        %Level.text = str(content.card.level)
        # set type
        %TypeIcon.texture = load("res://assets/icons/SUMMON_%s.svg" % content.card.type)
        # set abilities
        if len(content.card.abilities) == 2:
            %AbilityIcon1.texture = load("res://assets/icons/ABILITY.svg")
            %AbilityIcon2.texture = load("res://assets/icons/ABILITY.svg")
        elif len(content.card.abilities) == 1:
            %AbilityIcon1.texture = load("res://assets/icons/ABILITY.svg")
            %AbilityIcon2.texture = null
        else:
            %AbilityIcon1.texture = null
            %AbilityIcon2.texture = null
        # set attack
        if content.is_monster():
            %BattleAttributes.visible = true
            %AttackInfo.value  = content.attack
            %DefenseInfo.value = content.defense
            %HealthInfo.value  = content.health
            %AttackInfo.original_value  = content.card.attack
            %DefenseInfo.original_value = content.card.defense
            %HealthInfo.original_value  = content.card.health
        else: # is item
            %BattleAttributes.visible = false
    else:
        %Name.text = ""
        %Level.text = ""
        %TypeIcon.texture = null
        %AbilityIcon1.texture = null
        %AbilityIcon2.texture = null
        %BattleAttributes.visible = false
