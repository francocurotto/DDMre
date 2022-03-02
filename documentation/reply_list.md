# Reply documentation
The reply is a dictionary returned by the "update" function of the engine. It gives information about the result of a command execution.

# Reply Keys
- `valid`: True if the command is a legal move in the game, i.e., it changed the state of the duel. The rest of the keys depend if the valid key is True or False.

# Reply Keys when valid=True
- `result`: Name of the result of the command. 
- `flags`: list of reply flags. Flags are indicator of an event ocurred during the the excecution of the command. The flags are:
    - `NEWTURN`: used when a new turn starts
    - `PLAYERSWITCH`: used when the control of the duel is switched between players
    - `ENDDUEL`: used when the duel ends

The rest of the keys depend on the result:
## ROLL
- `roll`: list of sides rolled:
    - {`"crest"`:name of crest, `"mult"`:multiplier of side}

## DIM 
(no extra keys)

## SKIP 
(no extra keys)

## MOVE
- `monster`: name of the moving monster
- `origin`: origin position of movememnt (y,x)
- `dest`: destination position of movement (y,x)

## MLATTACK
- `monster`: name of attacking monster

## DIRECTATTACK
- `monster`: name of attacking monster
- `target`: name of target monster
- `advantage`:
    - `"ADV"`: attacker has advantage over target 
    - `"DAV"`: attacker has disadvantage over target 
    - `"NOA"`: no advantage or disadvantage
- `power`: power amount of attack
- `damage`: damage amount
- `kill`: True if target is killed

## REPLYATTACK
- `monster`: name of attacking monster
- `target`: name of target monster
- `advantage`: (see DIRECTATTACK)
- `power`: power amount of attack

## GUARD
- `monster`: name of attacking monster
- `target`: name of target monster
- `defense`: defense amount
- `retaliation`: True if attacker gets damaged in retaliation
- `damage`: damage amount
- `kill`: True if damaged monster is killed

## WAIT
- `target`: name of target monster
- `damage`: damage amount
- `kill`: True if damaged monster is killed

## ENDTURN
(no extra keys)

# Reply Keys when valid=False
- `error`: Error name that make the command invalid.
- `args`: tuple of arguments that complement the error.

The list of errors with thier respective args are:
##### DuplicatedDice
- Description: Trying to roll the same dice twice

##### DiceAlreadyUsed
- Description: Trying to roll a used (dimensioned) dice

##### OOBDimIndex
- Description: Trying to summon a dimension out of index

##### NotPlayerMonster
- Description: Not player monster found at selected position when expected
- `args`: 
    1. selected position `(y,x)`

##### NotOpponentTarget
- Description: Not opponent target found at selected position when expected
- `args`: 
    1. selected position `(y,x)`

##### AttackOutOfRange
- Description: Trying to attack a target out of range

##### MonsterInCooldown
- Description: Trying to attack with a monster that already did this turn
- `args`:
    1. attacking monster name

##### NotPathFound
- Description: Trying to move to a monster where there is not a valid path
- `args`:
    1. origin position of path `(y,x)`
    2. destination position of path `(y,x)`

##### NetUnconnected
- Description: Trying to dimension a dice not connected to the player path

##### OOBTilePos
- Description: Trying to place a tile out of dungeon bounds
- `args`:
    1. position of out of bound tile `(y,x)`

##### NotDungeonTile
- Description: Not dungeon tile found at selected position when expected
- `args`:
    1. selected position `(y,x)`

##### TileOverlaps
- Description: Trying to dimension a tile overlaping another tile

##### NotEnoughCrests
- Description: Not having  enough crests to perform an action
- `args`:
    1. crest name
