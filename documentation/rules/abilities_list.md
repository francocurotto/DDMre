# Common Abilities

## TUNNEL

## FLY

## ARCHER

## NEUTRAL

# Dimension Abilities
## DIMCURE (AMOUNT, NUMBER, COST, CREST)
Restore AMOUNT HEALTH to NUMBER (different) player monster(s).
Cost: COST x CREST

## DIMCUREALL (AMOUNT) 
Restore AMOUNT HEALTH to all player monsters. This ability cannot be skipped.

## DIMKILLWEAKEST
Excluding this monster, destroy the monster with the lowest ATTACK (after abilities effect computation).

## DIMKILLTUNNEL (COST, CREST)
Destroy one monster with the (active) ability TUNNEL.
Cost: COST x CREST

## DIMKILLTUNNELALL (COST, CREST)
Destroy all monsters with the (active) ability TUNNEL.
Cost: COST x CREST

## DIMADDCREST (CREST, AMOUNT)
Add AMOUNT CREST crest(s) to player crest pool. This ability cannot be skipped.

## DIMTRADECREST (COST)
Pay COST crest(s) of one type. Add for one crest of any type in player crest pool.

## EXODIA
Win the game if player controls "R Leg of Forbidden", "L Leg of Forbidden", "L Arm of Forbidden" and "R Arm of Forbidden". This ability cannot be skipped.

## DIMBUFFDEADTYPE (TYPE)
For each dead monster of type TYPE (of both players), add the (original) attack and defense of the dead monster to monster. This ability cannot be skipped.

# Continuous Abilities
## STOPFLY
Negate all FLY abilities.

## STOPTUNNEL
Negate all TUNNEL abilities.

## TURNSLOWTYPE (TYPE)
TYPE monsters can only move once every two turns, starting forbidding movement in each player next turn and re-enabling it in the turn after the next. NOTE: Two or more of instances of this ability can be stacked to cancel movement completely.

## BUFFTYPE (TYPE, ATTR, AMOUNT)
Raise ATTR of all TYPE monsters by AMOUNT.

## PROTECTTYPE (TYPE)
Reduce (attack or ability) damage done to all TYPE monsters to 0.

## FROZEN
Monster cannot move.

## MOVELIMIT (LIMIT)
Monster can move a maximum of LIMIT tiles per turn.

## RAISESPEED (AMOUNT)
Monster can move up to AMOUNT tiles per movement crest.

# Attack Abilities
## RAISEATTACK (MAX)
Raise attack power by 10x the number of payed ATTACK crest (additional to the crest for attacking), up to a maximum of MAX.
Cost: (1..MAX) x ATTACK

# Reply Abilities
## REDUCEDAMAGE (COST, CREST, AMOUNT)
Reduce damage dealt during attack by AMOUNT.
Cost: COST x CREST

## REDUCEDAMAGEINF
Reduce damage dealt during attack by 10x the number of payed defense crests, with no limit.
Cost: (1..99) x DEFENSE

## SHIFTDAMAGE (COST, CREST)
Shift all the damage dealt by an attack to another player monster.
Cost: COST x CREST

## PROTECTSELF (COST, CREST) 
Reduce damage dealt during attack to 0.
Cost: COST x CREST

## ADDFOEDEFENSE (COST, CREST)
Permanently and before attack calculations, add attacking monster DEFENSE to monster DEFENSE.
Cost: COST x CREST

# Standing Abilities
## KILLBLOCK (COST, CREST)
Remove a block tile.
Cost: COST x CREST

## BUFFDAMAGE (ATTR, COST, CREST)
Raise ATTR by total damage dealt to monster (monster max. health minus current health).
Cost: COST x CREST

## BUFFSELF (ATTR, COST, CREST, AMOUNT)
Raise ATTR by AMOUNT.
Cost: COST x CREST

## TRADEHEALTH (AMOUNT, COST, CREST)
Deal AMOUNT damage to monster and opponent monster.
Cost: COST x CREST

## STEALMONSTER (COST, CREST)
Destroy monster. Select an opponent monster and gain control of that monster for the rest of the duel. Move the controlled monster to the last position of monster.
Cost: COST x CREST

## MINDCONTROL (COST, CREST)
Gain control of one opponent monster till the end of the turn.
Cost: COST x CREST

## ROLLLEVELKILL (COST, CREST)
Choose a level (1 to 4). The ability cost is increased by the level selected x CREST crest. Choose a direction (left, right, up, down). Move the monster in the chosen direction. If it hits a flying-monster, continue movement without affecting the hit monster. If it hits a non-flying-monster/item whose level is lower or equal to the selected level, destroy that monster/item and continue movement (items abilities are not activated). If it hits a non-flying-monster/item whose level is higher that the selected level, or a monster lord, or an empty tile, stop movement and locate the monster in the last visited unoccupied path tile.
Cost: COST+[1..4] x CREST

## RANGELEVELKILL (RANGE, COST, CREST)
Choose an opponent monster/item at range RANGE. The ability cost is increased by the level of the monster/item selected x CREST crest. Destroy the selected monster/item.
Cost: COST+[1..4] x CREST

## RANGEKILLALL (RANGE, COST, CREST)
Destroy all other monsters and items at a range of RANGE, except this monster.
Cost: COST x CREST

## DISTANCEATTACK (MAX, COST, CREST)
Until the end of the turn the maximum attack distance for monster becomes MAX, and the attack crest cost becomes 0. NOTE: Distance attacks can go through monsters, items and monster lords, but not through empty tiles and blocks.

Cost: COST x CREST
 
# Manual Item Abilities
## ITEMCURE (AMOUNT)
Restore monster AMOUNT HEALTH.

## ITEMDAMAGE (AMOUNT)
Deal AMOUNT damage to monster.

## TIMEMACHINE
Return monster to its previous location (location before its last movement).

## ITEMBUFF (ATTR, AMOUNT)
Raise monster ATTR in AMOUNT.

## ITEMCRESTKILL (CREST, AMOUNT)
Remove AMOUNT CREST crest(s) from player.

## MONSTERREBORN
Select a dice from player graveyard. Remove that dice from graveyard and add it to player dice pool.

## BLACKHOLE
Destroy all monsters and items.

# Dimension Item Ability
## GLUMINIZER
Double the movement cost of monsters. Only one Gluminizer ability can be activated per duel.

## WARPVORTEX
Summon a warp vortex in the dimensioned location.
