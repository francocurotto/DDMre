extends PanelContainer

# constants
const COMMON_ABILITIES = ["ARCHER", "FLY", "NEUTRAL", "TUNNEL"]

# signals callbacks
func on_tile_gui_toggled(tile_gui, toggled_on):
    var content = tile_gui.tile.content
    if toggled_on and content.is_summon():
        set_card_info(content.card)
        if content.is_monster():
            set_monster_info(content)
    else:
        clear_info()

func on_dice_gui_selected(dice):
    set_card_info(dice.card)

# private  functions
func clear_info():
        %Name.text = ""
        %Level.text = ""
        %TypeIcon.texture = null
        %AbilityIcon1.texture = null
        %AbilityIcon2.texture = null
        %BattleAttributes.visible = false    

func set_card_info(card):
    # set name 
    %Name.text = card.name
    # set level
    %Level.text = str(card.level)
    # set type
    %TypeIcon.texture = load("res://assets/icons/SUMMON_%s.svg" % card.type)
    # set abilities
    if len(card.abilities) == 2:
        %AbilityIcon1.texture = get_ability_icon(card.abilities[0])
        %AbilityIcon2.texture = get_ability_icon(card.abilities[1])
    elif len(card.abilities) == 1:
        %AbilityIcon1.texture = get_ability_icon(card.abilities[0])
        %AbilityIcon2.texture = null
    else:
        %AbilityIcon1.texture = null
        %AbilityIcon2.texture = null
    # set attack
    if card.TYPE == "MONSTER":
        %BattleAttributes.visible = true
        %AttackInfo.value  = card.attack
        %DefenseInfo.value = card.defense
        %HealthInfo.value  = card.health
        %AttackInfo.original_value  = card.attack
        %DefenseInfo.original_value = card.defense
        %HealthInfo.original_value  = card.health
    else: # is item
        %BattleAttributes.visible = false
    
func set_monster_info(monster):
    %AttackInfo.value  = monster.attack
    %DefenseInfo.value = monster.defense
    %HealthInfo.value  = monster.health

func get_ability_icon(ability):
    if ability.name in COMMON_ABILITIES:
        return load("res://assets/icons/ABILITY_%s.svg" % ability.name)
    else:
        return load("res://assets/icons/ABILITY.svg")
