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
"SUMMONS1": ["g2-5","g4-1","g6-10"]
"SUMMONS2": ["g17-15","g14-9","g12-2"]
```
- `g2-5`: 
    - `g2` : location in dungeon
    - `-` : separator
    - `5` : dice index in pool to summon

## Crests
Indicate the initial crest for each players.

Example:
```
"CRESTS1": {"movement":9,"attack":1,"defense":3,"magic":5,"trap":2}
"CRESTS2": {"movement":0,"attack":5,"defense":4,"magic":1,"trap":1}
```

## Hearts
Indicate the initial hearts for each player.

Example:
```
"HEARTS1": 3
"HEARTS2": 1
```
