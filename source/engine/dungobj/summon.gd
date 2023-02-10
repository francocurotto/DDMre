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
func activate_on_summon_abilities(dungeon):
    for ability in card.abilities:
        ability.on_summon(self, dungeon)

func negate_abilities():
    for ability in card.abilities:
        ability.negate()

# is functions
func is_summon():
    return true

func has_active_ability(name):
    for ability in card.abilities:
        if ability.name == name and not ability.is_negated():
            return true
    return false
