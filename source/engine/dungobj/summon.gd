extends "playerobj.gd"

# variables
var card
var last_pos # used for TimeMachine ability

func _init(_card, _player).(_player):
    card = _card

# public function
func activate_on_summon_abilities(dungeon):
    for ability in card.abilities:
        ability.on_summon(self, dungeon)

func has_ability(name):
    for ability in card.abilities:
        if ability.name == name:
            return true
    return false

func negate_abilities(dungeon):
    for ability in card.abilities:
        ability.negate(self, dungeon)

# is functions
func is_summon():
    return true
