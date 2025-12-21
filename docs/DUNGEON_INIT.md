# Dungeon Layout
Define the initial layout by locating the empty tiles, block tiles, dungeon paths and monster lords.

Example:
```
{
  "DUNGEON": [
    "OOOOOOLOOOOOO",
    "OOOOOOPOOOOOO",
    "OOOOOOPOOOOOO",
    "OOOOOOPOOOOOO",
    "OOOOOOPOOOOOO",
    "OOOOOOPOOOOOO",
    "OOOOOOPOOOOOO",
    "OOOOOOPOOOOOO",
    "OOOOOOOOOOOOO",
    "XXXXXNNNXXXXX",
    "OOOOOOOOOOOOO",
    "OOOOOOpOOOOOO",
    "OOOOOOpOOOOOO",
    "OOOOOOpOOOOOO",
    "OOOOOOpOOOOOO",
    "OOOOOOpOOOOOO",
    "OOOOOOpOOOOOO",
    "OOOOOOpOOOOOO",
    "OOOOOOlOOOOOO"]
}
```
- `O`: empty tile
- `X`: block tile
- `l`: player 1 monster lord
- `L`: player 2 monster lord
- `p`: player 1 path
- `P`: player 2 path
- `N`: neutral path

# Debug Options
This options should be used only for debugging purposes. Options with 1 are for player 1, and 2 for player 2.

## Summons
Place player summons at the start of the game. Summons must be placed on a tile with dungeon path defined by the dungeon layout.

Example:
```
"SUMMONS1": [{"POS":"g2","DICE":5}, "POS":g4, "DICE":1}]
"SUMMONS2": [{"POS":"g17","DICE":15}, {"POS":"g14","DICE":9}]
```
- {"POS":"g2","DICE":5}:
    - `g2` : location in dungeon
    - `5` : dice index in pool to summon

## Crests
Indicate the initial crest for each players.

Example:
```
"CRESTS1": {"MOVEMENT":9,"ATTACK":1,"DEFENSE":3,"MAGIC":5,"TRAP":2}
"CRESTS2": {"MOVEMENT":0,"ATTACK":5,"DEFENSE":4,"MAGIC":1,"TRAP":1}
```

## Hearts
Indicate the initial hearts for each player.

Example:
```
"HEARTS1": 3
"HEARTS2": 1
```
