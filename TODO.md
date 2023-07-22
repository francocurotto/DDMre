### SOLID
- check roll_level_kill
- change activate_dict["pos"]

# abilities
- refactor abilities
- bug: when negate ability, if negated monster is killed, the ability is disabled again
    - fix changing disable for negate in summon.negate_abilities (TEST)
- potential bug: negating a dim ability and reenabling it will reactivate the ability (maybe cannot be triggered)

### GODOT4
- make it work without errors
- add proper godot4 documentation
