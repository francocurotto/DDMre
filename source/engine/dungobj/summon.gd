extends "playerobj.gd"

# variables
var card

func _init(_card, _player).(_player):
    card = _card
    for ability in card.abilities:
        ability.on_summon(self)

# public function
func has_ability(name):
    for ability in card.abilities:
        if ability.name == name:
            return true
    return false

# is functions
func is_summon():
    return true
