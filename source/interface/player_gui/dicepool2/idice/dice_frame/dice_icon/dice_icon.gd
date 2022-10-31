tool
extends MarginContainer

export (String, "DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM") var type = "DRAGON" setget set_type

# constants
const TYPEDICT = {"DRAGON"      : Color(1.0, 0.2, 0.2, 1.0),
                  "SPELLCASTER" : Color(0.8, 0.8, 0.8, 1.0),
                  "UNDEAD"      : Color(1.0, 1.0, 0.2, 1.0),
                  "BEAST"       : Color(0.2, 1.0, 0.2, 1.0),
                  "WARRIOR"     : Color(0.2, 0.2, 1.0, 1.0),
                  "ITEM"        : Color(0.2, 0.2, 0.2, 1.0)}

# onready varaibles
#onready var dice_background = $DiceBackground
#onready var card_icon = $CardContainer/CardIcon

func set_type(_type):
    type = _type
    print(TYPEDICT[type])
    $DiceBackground.modulate = TYPEDICT[type]
    $CardContainer/CardIcon.texture = load("res://art/icons/TYPE_" + type  + ".png")
