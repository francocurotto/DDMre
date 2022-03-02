# List of commands
The "update" function of the engine requires as a parameter a dictionary with the information of a command issued by the user or CPU. Below is a list of all possible commands in any given state of the engine.

## ROLL [ROLL state]
Roll dice set.
- command: `ROLL`
- dice: `[0..14, 0..14, 0..14]` (list of non-repeating ints)

## DIM [DIM state]
Dimension dice in dungeon, in the shape of net, at position pos, and applying transformations trans.
- command: `DIM`
- dice: `0..2` (int)
- net: `NX` (net string, see appendix)
- pos: `(0..18, 0..12)` (tuple of ints)
- trans: `[T1,T2,...]` (list of transformations, see appendix)

## SKIP [DIM state]
Skip dimension.
- command: `SKIP`

## MOVE [DUNGEON state]
Move monster from position origin to position dest.
- command: `MOVE`
- origin: `(0..18, 0..12)` (tuple of ints)
- dest: `(0..18, 0..12)` (tuple of ints)

## ATTACK [DUNGEON state]
Attack opponent monster or monster lord at position dest, with monster at position origin.
- command: `ATTACK`
- origin: `(0..18, 0..12)` (tuple of ints)
- dest: `(0..18, 0..12)` (tuple of ints)

## GUARD [REPLY state]
Defend attack from opponent monster.
- command: `GUARD`

## WAIT [REPLY state]
Do not reply to an attack from opponent monster.
- command: `WAIT`

## ENDTURN [DUNGEON state]
Finish turn.
- command: `ENDTURN`

# Appendix
## List of Nets
```
  T1     T2     Z1     Z2     X1     X2  
[][][] [][]   [][]   [][]     []     []  
  ()     ()[]   ()     ()   []()[] []()  
  []     []     []     [][]   []     [][]
  []     []     [][]   []     []     []  
                                         
  M1   M2     S1     S2     L1           
[][]   []     []     []     []           
  ()   []()   []()[] []()   []           
  [][]   [][]   []     [][] ()[]         
    []     []   []     []     []         
                              []         
```
(): center of net, where summon is summoned

## List of Transformations
- `TCW`: Turn clockwise
- `TAW`: Turn anti-clockwise
- `FUD`: Flip up-down
- `FLR`: Flip left-right
