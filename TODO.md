### SOLID
- fix is_monster() and not is_flying() in pass/target behaviours
- refactor dungobj
- refactor tiles/net
- standarize cmd syntax and context checks

# state
- fix place summon, place vortex, place path to react accordingly to invalid place
# abilities
- bug: when negate ability, if negated monster is killed, the ability is disabled again
- potential bug: negating a dim ability and reenabling it will reactivate the ability (maybe cannot be triggered)

### GODOT4
- add proper godot4 documentation
