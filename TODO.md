### SOLID

- refactor abilities

- refactor summon card
    - create_ability

- refactor summon
    - initialize_abilities
    - negate_abilities
    - get_dim_state_ability
    - has_active_ability
    - has_active_standing_ability

- refactor monster
    - activate_ability
    - activate_reply_ability

- refactor states
    - standarize cmd syntax and context checks
    - fix place summon, place vortex, place path to react accordingly to invalid place
    - make no dicepool create random dicepool, make no dungeon create default dungeon

# state
# abilities
- bug: when negate ability, if negated monster is killed, the ability is disabled again
- potential bug: negating a dim ability and reenabling it will reactivate the ability (maybe cannot be triggered)

### GODOT4
- add proper godot4 documentation
