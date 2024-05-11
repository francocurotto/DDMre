extends "res://engine/abilities/monster_abilities/monster_ability.gd"
## Ability that is continuously activated that during duel.
##
## Continuous ablilities are triggered without limits every time monsters are 
## summoned, and when turn passes.

#region constants
const TYPE = "CONTINUOUS"
#endregion

#region public functions
## When ability is activated, connect ability with events that trigger the 
## abilities effects.
func activate():
    Events.new_summon.connect(on_new_summon)
    Events.next_turn.connect(on_next_turn)
#endregion

## When ability is deactivated, disconnect ability with trigger events.
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

## When ability is negated for the first time, deactivate ability effect.
func negate():
    super()
    if negate_count == 1:
        deactivate()

## When last negation on ability is removed, re-activate ability effects.
func remove_negate():
    super.remove_negate()
    if negate_count == 0:
        activate()

#region signals callbacks
func on_new_summon(_summon):
    pass

func on_next_turn(_player, _turn):
    pass
#endregion

#region is functions
func activates_on_dim():
    return true
#endregion
