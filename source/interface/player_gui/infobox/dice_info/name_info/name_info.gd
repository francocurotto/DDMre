extends HBoxContainer

# onready variables
onready var card_name = $Name
onready var type = $TLA/Type
onready var level = $TLA/Level
onready var ability = $TLA/Ability

# set functions
func set_info(kwargs):
    var card = kwargs["card"]
    var hidename = kwargs["hidename"]
    
    # set name
    if hidename: # case oponent item
        card_name.text = "???"
    else: # case player item 
        card_name.text = kwargs["card"].name
    
    # set type 
    type.texture = load("res://art/icons/TYPE_" + card.type + ".png")
    
    # set level
    level.text = str(card.level)
   
    # set ability
    if card.ability.empty():  # item has no ability
        ability.texture = null
    else: # item has ability
        ability.texture = load("res://art/icons/ABILITY.png")
