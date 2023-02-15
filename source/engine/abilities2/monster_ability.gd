extends "ability.gd"

# variables
var monster
var negate_count = 0

func _init(ability_dict).(ability_dict):
    pass

# public functions
func initialize(_monster, _dungeon):
    .initialize(_monster, _dungeon)
    monster = _monster

func negate():
    """
    When ability is negated by other effect, increase negate count.
    If it is first negate, disable ability.
    """
    negate_count += 1
    if negate_count == 1:
        disable()

func remove_negate():
    """
    When negation on ability is removed, reduce negate count.
    If last negate, reenable ability.
    """
    negate_count -= 1
    if negate_count == 0:
        on_dimension()

func on_dimension():
    pass

func disable():
    pass

# is functions
func is_disabled():
    return negate_count > 0
