extends "playerobj.gd"

# variables
var card

func _init(_card, _player).(_player):
    card = _card

# setget functions
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
    deactivate_abilities()
    tile.empty_tile()

func initialize_abilities(dungeon):
    for ability in card.abilities:
        ability.initialize(self, dungeon)

#GODOT4: use array filter
func activate_dim_abilities():
    for ability in card.abilities:
        if ability.activates_on_dim():
            ability.activate()

func deactivate_abilities():
    for ability in card.abilities:
        if not ability.is_negated():
            ability.deactivate()

func negate_abilities():
    for ability in card.abilities:
        ability.negate()

# is functions
func is_summon():
    return true

func has_ability(name):
    #GODOT4: use array any
    for ability in card.abilities:
        if ability.name == name:
            return true
    return false

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

func has_dim_manual_ability():
    #GODOT4: use array any
    for ability in card.abilities:
        if ability.is_dim_manual():
            return true
    return false

func has_item_manual_ability():
    #GODOT4: use array any
    for ability in card.abilities:
        if ability.is_item_manual():
            return true
    return false
