# List of commands
The "update" function of the engine requires as a parameter a dictionary with the information of a command issued by the user or CPU. Below is a list of all possible commands in any given state of the engine.

## ROLL [ROLL state]
Roll dice trio.
- name: `ROLL`
- dice: `[0..14, 0..14, 0..14]` (list of non-repeating ints)

## DIM [DIM state]
Dimension dice in dungeon, in the shape of net, at position pos, applying transformations trans.
- name: `DIM`
- dice: `0..2` (int)
- net: `NX` (net string, see appendix)
- pos: `(0..18, 0..12)` (tuple of ints)
- trans: `[T1,T2,...]` (list of transformations, see appendix)

## SKIP [DIM state, DIM ABILITY state, ITEM ABILITY state]
Skip dimension, or ability effect.
- name: `SKIP`

## MOVE [DUNGEON state]
Move monster from position origin to position dest.
- name: `MOVE`
- origin: `(0..18, 0..12)` (tuple of ints)
- dest: `(0..18, 0..12)` (tuple of ints)

## ATTACK [DUNGEON state]
Attack opponent monster or monster lord at position dest, with monster at position origin. Optionally activate ability defined by ability_dict.
- name: `ATTACK`
- origin: `(0..18, 0..12)` (tuple of ints)
- dest: `(0..18, 0..12)` (tuple of ints)
- ability_dict: attack ability dict (optional)

## JUMP [DUNGEON state]
Move monster through a vortex from position origin to position dest.
- name: `JUMP`
- origin: `(0..18, 0..12)` (tuple of ints)
- dest: `(0..18, 0..12)` (tuple of ints)

## ENDTURN [DUNGEON state]
Finish turn.
- name: `ENDTURN`

## GUARD [REPLY state]
Defend attack from opponent monster. Optionally activate ability defined by ability_dict.
- name: `GUARD`
- ability_dict: reply ability dict (optional)

## WAIT [REPLY state]
Do not defend to an attack from opponent monster. Optionally activate ability defined by ability_dict.
- name: `WAIT`
- ability_dict: reoly ability dict (optional)

## ABILITY [DUNGEON state]
Cast monster standing ability.
- name: `ABILITY`
- pos: `(0..18, 0..12)` (tuple of ints)
- ability_dict : `ability_dict`(optional)

## ABILITY [DIM ABILITY state, ITEM ABILITY state]
Cast monster dim or.item state ability.
- name: `ABILITY`
- ability_dict : `ability_dict`(optional)

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
