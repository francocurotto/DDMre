Here I document the mistakes and oddities that I found while analysing the original game while working in this project. Most of the mistakes stem from weirdly of flat out wrong implementation of monster abilities. Since my goal is of reimplementation, unless stated otherwise, those weird behavior are kept in the reimplemented game.

# Weird logic
- In the original, a block tile forbid the dimension of a dice not only in its position, but in its 4 adjacent neighbors. In this implementation, a block in forbids dimensions only in its position, but the original behavior can be replicated by adding more block tiles.
- Mystic Horseman ability is essentially the same as the one from Swamp Battleguard RAISEATTACK, except it cost a magic crest instead of an attack crest, and it has to be activated before attack. Functionally it has the same utility. The additional ability DUNGRAISEATTACK is created to copy Horseman ability
- The "reduce damage" abilities from Saggi the Dark Clown, Castle of D. Magic and Pumpking the King of Ghosts make no sense in their implementation. It is basically a worst "guard": it costs more defense crests, and it does not deals retaliation damage. It would only make sense if the ability reduced more damage than the monster defense (in all the cases the defense is equal to the reduced damage). Nevertheless this behavior is kept in this implementation.
- Maybe due to a bad implementation (see typo section), but Dark-eyes Illusionist ability is the same as the one from Strike Ninja, yet, the first one is a higher level dice, a worst monster, and the ability cost more crests. This makes Dark-eyes Illusionist significantly worst with no apparent reason.
- For Magician Dragon first ability, it adds attacking monster defense to its own defense permanently, but it cannot be used in the current attack to guard, so you must survive the (unguarded) attack for the ability to be useful.
- When Gluminizer ability is combined with a monster with RAISESPEED ability, the combination goes as follows: 1. the cost of movement is computed with the RAISESPEED ability by dividing the cost (in float), 2. the Gluminizer ability is computed by multiplying the float cost, 3. the cost is rounded to the highest int (ceil). Example:
    - GLUMINIZER+RAISESPEED(3) costs per tile: 1,2,2,3,4,4,5,6,6...
It make more sense to compute the cost by only using ints to get:
    - GLUMINIZER+RAISESPEED(3) costs per tile: 2,2,2,4,4,4,6,6,6...
- Resurrection Scroll returns a dice from the graveyard to the dice pool. Since the number of dimension is counted using the number of used dice in dice pool, the Resurrection Scroll effect essentially gives the player an extra dimension in the dungeon.

# Typos
- Saggi the Dark Clown ability saids that it reduces the damage to "an ally", yet it only works when he himself is being attacked. Therefore it is equivalent to the "reduce damage" ability of Castle of D. Magic and Pumpking the King of Ghosts (i.e. the REDUCEDAMAGE ability).
- Similar to Saggi, Dark-eyes Illusionist ability says that in negates the attack and effect on one ally, yet it only work when he himself it's under attack.
- Knight of Twin Swords ability says that it can attack a monster more up to 3 times per turn, yet it can only attack once. Instead is ability is RAISEATTACK with MAX 4.
- For Magician Dragon second ability, it says that it destroys everything a within a 3x3 grid, but instead, it destroys everything at range 3.

# Bugs
- When the attack or defense of a monster goes over 120 by many BUFFTYPE abilities, the stat goes immediately down to 0 for some reason. Still unsure how that affect actual attacks and guards.
