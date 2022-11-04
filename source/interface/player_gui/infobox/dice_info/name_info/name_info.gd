extends HBoxContainer

# onready variables
onready var tla = $TLA
onready var cardname = $Name

# setget functions
func set_info(kwargs):
    var card = kwargs["card"]
    var hidename = kwargs["hidename"]
    set_cardname(card.name, hidename)
    tla.set_tla(card)

# private functions
func set_cardname(_cardname, hidename):
    if hidename: # case oponent item
        cardname.text = "???"
    else: # case player item
        cardname.text = _cardname
