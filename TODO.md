### SOLID
- fix ability_dict/activate_dict inconsistency

- refactor summon card
    - create_ability

- refactor summon
    - initialize_abilities
    - negate_abilities
    - has_active_ability
    - has_active_standing_ability

# abilities
- refactor abilities
- bug: when negate ability, if negated monster is killed, the ability is disabled again
- potential bug: negating a dim ability and reenabling it will reactivate the ability (maybe cannot be triggered)

### GODOT4
- make it work without errors
- add proper godot4 documentation
