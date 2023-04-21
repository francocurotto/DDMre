extends "playerobj.gd"

# variables
var card

func _init(_card, _player).(_player):
    card = _card

# getset functions
func get_ability(name):
    """
    Get ability from ability list.
    """
    for ability in card.abilities:
        if ability.name == name:
            return ability

# public function
func initialize_abilities(dungeon):
    for ability in card.abilities:
        ability.initialize(self, dungeon)

func negate_abilities():
    for ability in card.abilities:
        ability.disable()

func get_state_dim_ability():
    for ability in card.abilities:
        if ability.is_state_dim():
            return ability
    return null

# is functions
func is_summon():
    return true

func has_active_ability(name):
    for ability in card.abilities:
        if ability.name == name and not ability.is_negated():
            return true
    return false

func has_active_standing_ability():
    for ability in card.abilities:
        if ability.is_standing() and not ability.is_negated():
            return true
    return false 
