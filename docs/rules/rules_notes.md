# Rule Notes
Some rules clarifications.

## Dimension Notes
For a valid dimension on the dungeon, the dice net must satisfy the following conditions:
- The net must be in-bounds on the dungeon.
- The net must not overlap other path tiles or block tiles.
- Al least one of the net tiles must be neighbour of a player path tile.

## Move Notes
- Monsters can move as many times as the player wants in its turn.
- Monsters normally cannot move through other monsters (from player or opponent).
- Monsters normally cannot move through items, but can land on them to activate them.
- No two monsters or (unactivated) items can occupy the same position, regardless of any ability.

## Attack Notes
- Monsters can attack only once per turn.

## Attack Damage Computation
Table below show the computation of the damage done to a monster when an opponent monster attacks it. The damage done changes if the attacking monster has a type advantage or disadvantage, or is neutral (no advantage or disadvantage), and if the attacked monster reply action is WAIT or GUARD. If the damage is negative, the magnitude damage is done in retaliation to the attacking monster.

| Reply | Neutral            | Advantage             | Disadvantage              |
|-------|--------------------|-----------------------|---------------------------|
| WAIT  | attack             | attack+10             | attack-10[^1]             |
| GUARD | attack-defense[^1] | attack-defense+10[^1] | attack-defense-10[^1]     |

[^1]: Retaliation damage is done to attacker if damage is negative.
