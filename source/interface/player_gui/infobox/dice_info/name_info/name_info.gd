extends HBoxContainer

# onready variables
onready var cardname = $Name
onready var type = $TLA/Type
onready var level = $TLA/Level
onready var ability = $TLA/Ability

# setget functions
func set_info(kwargs):
    var card = kwargs["card"]
    var hidename = kwargs["hidename"]
    set_cardname(card.name, hidename)
    set_type(card.type)
    set_level(card.level)
    set_ability(card.ability)

# private functions
func set_cardname(_cardname, hidename):
    if hidename: # case oponent item
        cardname.text = "???"
    else: # case player item
        cardname.text = _cardname

func set_type(_type):
    type.texture = load("res://art/icons/TYPE_" + _type + ".png")

func set_level(_level):
    level.text = str(_level)

func set_ability(_ability):
    if _ability.empty():  # item has no ability
        ability.texture = null
    else: # item has ability
        ability.texture = load("res://art/icons/ABILITY.png")
