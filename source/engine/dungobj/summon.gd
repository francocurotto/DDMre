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
    #GODOT4: use array filter
    for ability in card.abilities:
        if ability.name == name:
            return ability

# public function
func destroy():
    negate_abilities()
    tile.empty_tile()

func initialize_abilities(dungeon):
    for ability in card.abilities:
        ability.initialize(self, dungeon)

func negate_abilities():
    for ability in card.abilities:
        ability.disable()

# is functions
func is_summon():
    return true

func has_active_ability(name):
    #GODOT4: use array any
    for ability in card.abilities:
        if ability.name == name and not ability.is_negated():
            return true
    return false

func has_active_standing_ability():
    #GODOT4: use array any
    for ability in card.abilities:
        if ability.is_standing() and not ability.is_negated():
            return true
    return false 

func has_dim_state_ability():
    #GODOT4: use array any
    for ability in card.abilities:
        if ability.is_dim_state():
            return true
    return false

func has_item_state_ability():
    #GODOT4: use array any
    for ability in card.abilities:
        if ability.is_item_state():
            return true
    return false
