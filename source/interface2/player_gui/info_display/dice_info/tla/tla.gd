tool
extends HBoxContainer

# export variables
export (String, "DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM") var type = "DRAGON" setget set_type
export (int, 1, 4) var level = 3 setget set_level
export (bool) var ability = false setget set_ability

# setget functions
func set_tla(card):
    set_type(card.type)
    set_level(card.level)
    set_ability(not card.ability.empty())

func set_type(_type):
    type = _type
    if has_node("Type"):
        $Type.texture = load("res://art/icons/TYPE_" + type + ".png")

func set_level(_level):
    level = _level
    if has_node("Level"):
        $Level.text = str(level)

func set_ability(_ability):
    ability = _ability
    if has_node("Ability"):
        if ability:
            $Ability.texture = load("res://art/icons/ABILITY.png")
        else: # ability icon
            $Ability.texture = null
