# Rule Notes
Some rules clarifications that I didn't know where else to put. 

## Move Notes
- Monsters can move as many times as the player wants in its turn.
- Normal monsters cannot move through other monsters (from player or opponent).
- Normal monsters cannot move through items, but can step into them to activate them.
- No two monsters or (unactivated) items can occupy the same position, regardless of any ability.

# Attack Notes
- Monsters can attack only once per turn.
## Attack Damages
- Normal attack
    - not-guarding: damage = attack
    - guarding:     damage = attack-defense (retaliation if negative)
- Advantage attack:
    - not-guarding: damage = attack+10
    - guarding:     damage = attack-defense+10 (retaliation if negative)
- Disadvantage attack:
    - not-guading: damage = attack-10 (retaliation if negative)
    - guarding:    damage = attack-defense-10 (retaliation if negative)
