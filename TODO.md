### SOLID
- refactor dungobjs
    - refactor monster
- refactor dice
- refactor states
    - standarize cmd syntax and context checks
- refactor abilities

# state
- fix place summon, place vortex, place path to react accordingly to invalid place
- make no dicepool create random dicepool, make no dungeon create default dungeon
# abilities
- bug: when negate ability, if negated monster is killed, the ability is disabled again
- potential bug: negating a dim ability and reenabling it will reactivate the ability (maybe cannot be triggered)

### GODOT4
- add proper godot4 documentation
