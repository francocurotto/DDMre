extends "res://engine/abilities/linger_ability.gd"

# constants
const TYPE = "CONTINUOUS"

func _init(ability_dict):
    super(ability_dict)
    pass

# public functions
func activate():
    Events.dice_dimensioned.connect(on_new_summon)
    Events.next_turn.connect(on_next_turn)

func deactivate():
    # "if"s are not necessary for now, but are there for future proof.
    # If a continuous ability that uses the signals is negated on summon,
    # the disconnect will throw an error if not tested first, because the 
    # connections (on activate) are performed after the summon signal is 
    # triggered.
    if Events.new_summon.is_connected(on_new_summon):
        Events.new_summon.disconnect(on_new_summon)
    if Events.next_turn.is_connected(on_next_turn):
        Events.next_turn.disconnect(on_next_turn)

func negate():
    super.negate()
    if negate_count == 1:
        deactivate()

func remove_negate():
    super.remove_negate()
    if negate_count == 0:
        activate()

# signals callbacks
func on_new_summon(_summon, _net):
    pass

func on_next_turn(_player, _turn):
    pass

# is functions
func activates_on_dim():
    return true
