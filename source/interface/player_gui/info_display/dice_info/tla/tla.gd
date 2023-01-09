tool
extends HBoxContainer

# export variables
export (String, "DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM") var type = "DRAGON" setget set_type
export (int, 1, 4) var level = 3 setget set_level
export (String, "TUNNELING", "FLY", "ARCHER", "NEUTRAL", "OTHER", "NONE") var ability1 = "OTHER" setget set_ability1
export (String, "TUNNELING", "FLY", "ARCHER", "NEUTRAL", "OTHER", "NONE") var ability2 = "OTHER" setget set_ability2

# setget functions
func set_tla(card):
    set_type(card.type)
    set_level(card.level)
    set_abilities(card.abilities)

func set_type(_type):
    type = _type
    if has_node("Type"):
        $Type.texture = load("res://art/icons/TYPE_" + type + ".png")

func set_level(_level):
    level = _level
    if has_node("Level"):
        $Level.text = str(level)

func set_abilities(abilities):
    # set abilities icons
    for i in range(abilities.length):
        match i:
            0 : set_ability1(abilities.slot1.name)
            1 : set_ability2(abilities.slot2.name)
    # set no abilities
    for i in range(abilities.length, 2):
        match i:
            0 : set_ability1("NONE")
            1 : set_ability2("NONE")

func set_ability1(_ability):
    ability1 = _ability
    set_ability($Ability1, ability1)

func set_ability2(_ability):
    ability2 = _ability
    set_ability($Ability2, ability2)

func set_ability(rect, _ability):
    match _ability:
        "TUNNELING" : rect.texture = load("res://art/icons/ABILITY_TUNNELING.png")
        "FLY"       : rect.texture = load("res://art/icons/ABILITY_FLY.png")
        "ARCHER"    : rect.texture = load("res://art/icons/ABILITY_ARCHER.png")
        "NEUTRAL"   : rect.texture = load("res://art/icons/ABILITY_NEUTRAL.png")
        "OTHER"     : rect.texture = load("res://art/icons/ABILITY.png")
        "NONE"      : rect.texture = null
