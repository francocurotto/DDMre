extends "res://engine/abilities/linger_ability.gd"

# constants
const TYPE = "CONTINUOUS"

func _init(ability_dict):
    super(ability_dict)
    pass

# public functions
func activate():
    Events.connect("new_summon", Callable(self, "on_new_summon"))
    Events.connect("next_turn", Callable(self, "on_next_turn"))

func deactivate():
    # "if"s are not necessary for now, but are there for future proof.
    # If a continuous ability that uses the signals is negated on summon,
    # the disconnect will throw an error if not tested first, because the 
    # connections (on activate) are performed after the summon signal is 
    # triggered.
    if Events.is_connected("new_summon", Callable(self, "on_new_summon")):
        Events.disconnect("new_summon", Callable(self, "on_new_summon"))
    if Events.is_connected("next_turn", Callable(self, "on_next_turn")):
        Events.disconnect("next_turn", Callable(self, "on_next_turn"))

func negate():
    super.negate()
    if negate_count == 1:
        deactivate()

func remove_negate():
    super.remove_negate()
    if negate_count == 0:
        activate()

# signals callbacks
func on_new_summon(_summon):
    pass

func on_next_turn(_player, _turn):
    pass

# is functions
func activates_on_dim():
    return true
