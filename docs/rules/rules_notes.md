# Rule Notes
Some rules clarifications.

## Move Notes
- Monsters can move as many times as the player wants in its turn.
- Monsters normally cannot move through other monsters (from player or opponent).
- Monsters normally cannot move through items, but can land on them to activate them.
- No two monsters or (unactivated) items can occupy the same position, regardless of any ability.

## Attack Notes
- Monsters can attack only once per turn.

## Attack Damages
- Attack on a type without advantage or disadvantage
    - not-guarding: damage = attack
    - guarding:     damage = attack-defense (retaliation if negative)
- Attack on type with advantage:
    - not-guarding: damage = attack+10
    - guarding:     damage = attack-defense+10 (retaliation if negative)
- Attack on type with disadvantage
    - not-guading: damage = attack-10 (retaliation if negative)
    - guarding:    damage = attack-defense-10 (retaliation if negative)

| Reply | Neutral            | Advantage             | Disadvantage              |
|-------|--------------------|-----------------------|---------------------------|
| WAIT  | attack             | attack+10             | attack-10[^1]             |
| GUARD | attack-defense[^1] | attack-defense+10[^1] | attack-defense-10[^1]     |

[^1]: Retaliation damage is done to attacker if damage is negative.
